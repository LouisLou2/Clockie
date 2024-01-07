import 'package:clockie/service/network_service.dart';
import 'package:clockie/util/formattor.dart';
import 'package:hive/hive.dart';

class HolidaysRepo {
  static Set<String>?holidays;
  static late Box<Set<String>> box;
  static const String boxName='holidayBox';
  static bool isUpdating=false;
  static String formator=DateFormatter.DATE_FORMAT;
  static bool isBoxOpen()=>Hive.isBoxOpen(boxName);

  static bool ensureHolidayRepoReady(){
    if(holidays==null){
      initializeHolidayRepo();
      return false;
    }
    return true;
  }
  static void initializeHolidayRepo()async{
    if(!isBoxOpen()){
      box=await Hive.openBox<Set<String>>(boxName);
    }
    holidays=box.get('holidays');
    if(holidays!=null){
      box.close();
      return;
    }
    updateHolidays();
  }
  static Future<bool?> updateHolidays()async{
    if(isUpdating)return null;
    Set<String>? holidaysTmp=await NetworkService.getHolidays(DateTime.now().year);
    if(holidaysTmp==null)return false;
    holidays=holidaysTmp;
    if(!isBoxOpen()){
      box=await Hive.openBox<Set<String>>(boxName);
    }
    box.put('holidays', holidays!);
    isUpdating=false;
    box.close();
    return true;
  }
  static bool isHoliday(DateTime date){
    //此方法会被调用，说明之前就已经将holidays初始化好了
    return holidays!.contains(DateFormatter.format(date, formator));
  }
}