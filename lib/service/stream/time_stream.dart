import 'dart:async';
class TimeStream {
  static int prevMin=DateTime.now().minute;
  static int prevHour=DateTime.now().hour;
  static int prevDay=DateTime.now().day;
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
        //这里为什么还要加一个now.minute!=prevMin双重判断？
        //因为我发现，当应用在后台运行时，一个一个的流是正常还在运行的，但是会出现即使流到了，订阅这个流的StringBuilder并不刷新，好像在后台时就忽略这些流信号
        //这会出现一个状况就是，只能等到我再次进入应用起的下一个流信号(进入下一个分钟)才会刷新，这样就会出现一分钟之内不等的沉默
        //这里加一个now.minute!=prevMin就是为了解决这个问题，这样再次进入应用，发现与之前记录的分钟不一样，也要发出刷新信号
        //不要以为小时和天就不用这么做了，因为这个问题也会出现在小时和天上，设想一下，我在跨越小时的时候仍把它放在后台，
        // 这样下一次刷新只能等到我再次进入应用起的下一个小时，这甚至更糟糕
        callback = (timer) {
         var now=DateTime.now();
          if (now.second == 0||now.minute!=prevMin) {
            prevMin=now.minute;
            controller.add(null);
          }
        };
        break;
      case 2:
        callback = (timer) {
          var now=DateTime.now();
          if (now.minute == 0||now.hour!=prevHour) {
            prevHour=now.hour;
            controller.add(null);
          }
        };
        break;
      case 3:
        callback = (timer) {
          var now=DateTime.now();
          if (now.hour == 0||now.day!=prevDay) {
            prevDay=now.day;
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