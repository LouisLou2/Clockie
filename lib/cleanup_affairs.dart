import 'package:hive/hive.dart';
bool haveCleanUp=false;
bool isCleanUp=false;
void cleanUp()async{
  if(haveCleanUp||isCleanUp){
    return;
  }
  isCleanUp=true;
  // 关闭 Hive 连接
  await Hive.close();
  haveCleanUp=true;
  isCleanUp=false;
  print('Hive closed******************************************');
}