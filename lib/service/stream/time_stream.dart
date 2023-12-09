import 'dart:async';
class TimeStream {
  static List<Stream?>streams=List.filled(4, null);
  ///0：sec，1：min，2：hour,3:day
  static Stream? getTimeStream(int intervalCode) {
    assert(intervalCode>-1&&intervalCode<4);
    if(streams[intervalCode]!=null){
      return streams[intervalCode];
    }
    StreamController controller = StreamController.broadcast();//广播流,如果不是广播流，一个流对象只允许被一个监听者监听，就需要创建多个流对象
    void Function(Timer timer)callback= (timer) {};
    switch (intervalCode) {
      case 0:
        callback = (timer) {
          controller.add(null);
        };
        break;
      case 1:
        callback = (timer) {
          if (DateTime.now().second == 0) {
            controller.add(null);
          }
        };
        break;
      case 2:
        callback = (timer) {
          if (DateTime.now().minute == 0) {
            controller.add(null);
          }
        };
        break;
      case 3:
        callback = (timer) {
          if (DateTime.now().hour == 0) {
            controller.add(null);
          }
        };
        break;
    }
    Timer.periodic(const Duration(seconds: 1), callback);
    streams[intervalCode]=controller.stream;
    return streams[intervalCode];
  }
}
enum IntervalDepend{
  min,
  hour,
  day
}