import 'package:hive/hive.dart';

import '../alarm_model.dart';

/// 注意BinaryReader的各种读写方法，他可以支持写入不同长度的，我这里对于序号用了writeByte()/readByte(),所以不要int越界，这里我的值也不会超过太大，所以是安全的
class AlarmAdapter extends TypeAdapter<Alarm> {
  @override
  final int typeId = 1;

  @override
  Alarm read(BinaryReader reader) {
    final int numOfFields = reader.readByte();
    //这里使用
    final fields =[
      for (int i = 0; i < numOfFields; ++i) reader.read(),
    ];
    return Alarm.empty()
    //级联操作符
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..hour = fields[2] as int
      ..min = fields[3] as int
      ..isActive = fields[4] as bool
      ..pickNum=fields[5] as int
      ..days = fields[6] as List<bool>
      ..desc = fields[7] as String
      ..meantTime=fields[8] as String;
  }

  @override
  void write(BinaryWriter writer, Alarm obj) {
    writer
      ..writeByte(Alarm.fieldsNum)//字段数
      ..write(obj.id)
      ..write(obj.name)
      ..write(obj.hour)
      ..write(obj.min)
      ..write(obj.isActive)
      ..write(obj.pickNum)
      ..write(obj.days)
      ..write(obj.desc)
      ..write(obj.meantTime);
  }
  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AlarmAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}