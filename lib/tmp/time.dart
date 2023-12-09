import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;
void main1()async{
  tzdata.initializeTimeZones(); // 初始化时区数据库
  // 获取纽约和东京的时区信息
  tz.Location locationB = tz.getLocation('Asia/Tokyo');

  // 假设有一个 DateTime 对象表示的是纽约的时间
  DateTime currentTimeInA = DateTime.now();

  // 将当前纽约时间转换为东京时间
  tz.TZDateTime currentTimeInB = tz.TZDateTime.from(currentTimeInA, locationB);

  print('Current time in Local: $currentTimeInA');
  print('Current time in Tokyo: $currentTimeInB');
  // await init();
  // runApp(const MyApp());
}
void main2(){
  tzdata.initializeTimeZones(); // 初始化时区数据库
  DateTime now = DateTime.now();
  Map<String,tz.Location>map=tz.timeZoneDatabase.locations;
  print(map.length);
}