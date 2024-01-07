import 'package:hive/hive.dart';

class StringSetAdapter extends TypeAdapter<Set<String>> {
  @override
  final int typeId = 0; // 唯一标识适配器的 ID

  @override
  Set<String> read(BinaryReader reader) {
    final length = reader.readUint32(); // 读取 Set 的长度
    final set = <String>{};
    for (var i = 0; i < length; ++i) {
      final value = reader.readString(); // 读取每个字符串值
      set.add(value);
    }
    return set;
  }

  @override
  void write(BinaryWriter writer, Set<String> obj) {
    writer.writeUint32(obj.length); // 写入 Set 的长度
    for (final value in obj) {
      writer.writeString(value); // 写入每个字符串值
    }
  }
}