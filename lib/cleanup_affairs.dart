import 'package:hive/hive.dart';

void cleanUp(){
  // 关闭 Hive 连接
  Hive.close();
  print("Hive closed");
}