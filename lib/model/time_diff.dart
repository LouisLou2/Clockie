import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class TimeDiff{
  static const int fieldsNum=3;
  @HiveField(0)
  int countryCode;
  @HiveField(1)
  int cityCode;
  @HiveField(2)
  int hours;

  TimeDiff(this.countryCode,this.cityCode,this.hours);
}