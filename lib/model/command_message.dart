class CommandMessage{
  CommandMessage({
    required this.cmdCode,
    required this.id,
  });
  CommandMessage.fromJson(Map<String, dynamic> json)
      : cmdCode = json['cmdCode'],
        id = json['id'];
  final int cmdCode;
  final String id;

  Map<String,dynamic>toJson() => {
    'cmdCode':cmdCode,
    'id':id,
  };
  @override
  String toString()=>'{"cmdCode":$cmdCode, "id":"$id"}';//注意Json格式,双引号包裹键
}