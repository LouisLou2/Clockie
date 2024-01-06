import 'package:hive/hive.dart';
bool haveCleanedUp=false;
bool isCleaning=false;
void cleanUp()async{
  if(haveCleanedUp||isCleaning){
    return;
  }
  isCleaning=true;
  // 关闭 Hive 连接
  await Hive.close();
  haveCleanedUp=true;
  isCleaning=false;
}