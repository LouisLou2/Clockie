import 'package:clockie/model/time_diff.dart';
import 'package:hive/hive.dart';

class TimeDiffAdapter extends TypeAdapter<TimeDiff>{
  @override
  final typeId = 0;

  @override
  TimeDiff read(BinaryReader reader) {
    int numOfFields = reader.readByte();
    var fields = [
      for(int i=0;i<numOfFields;i++) reader.read(),
    ];
    return TimeDiff(fields[0],fields[1],fields[2]);
  }


  @override
  void write(BinaryWriter writer, TimeDiff obj) {
    writer.writeByte(TimeDiff.fieldsNum);
    writer.writeByte(0);
    writer.write(obj.countryCode);
    writer.writeByte(1);
    writer.write(obj.cityCode);
    writer.writeByte(2);
    writer.write(obj.hours);
  }
}