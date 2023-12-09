class CommandMessage{
  CommandMessage({
    required this.cmdCode,
    required this.id,
    this.uniqueId=-1,
  });
  CommandMessage.fromJson(Map<String, dynamic> json)
      : cmdCode = json['cmdCode'],
        id = json['id'],
        uniqueId=json['uniqueId']??-1;
  final int cmdCode;
  final String id;//可以是单个（安卓闹钟unique Id）id，也可以是多个id，用:分隔,具体使用逻辑由cmdCode决定
  final int uniqueId;

  Map<String,dynamic>toJson() => {
    'cmdCode':cmdCode,
    'id':id,
    'uniqueId':uniqueId,
  };
  @override
  String toString()=>'{"cmdCode":$cmdCode, "id":"$id","uniqueId":$uniqueId}';//注意Json格式,双引号包裹键
}