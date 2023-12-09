import 'package:hive/hive.dart';

void cleanUp()async{
  // 关闭 Hive 连接
  await Hive.close();
  print('Hive closed******************************************');
}