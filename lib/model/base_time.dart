class BaseTime{
  int min;
  int sec;
  int mili;
  BaseTime(this.min,this.sec,this.mili);
  BaseTime.zero():min=0,sec=0,mili=0;
  BaseTimeStr toBaseTimeStr(){
    return BaseTimeStr.fromInt(min, sec, mili);
  }
  String toString(){
    return '${min>=10?'$min':'0$min'}.${sec>=10?'$sec':'0$sec'}.${mili>=10?'$mili':'0$mili'}';
  }
  static toTimeStr(int min, int sec, int mili){
    return '${min>=10?'$min':'0$min'}:${sec>=10?'$sec':'0$sec'}:${mili>=10?'$mili':'0$mili'}';
  }
}
class BaseTimeStr{
  late String min;
  late String sec;
  late String mili;
  BaseTimeStr(this.min,this.sec,this.mili);
  BaseTimeStr.fromInt(int amin, int asec, int amili) {
    assert(amin>=0&&asec>=0&&amili>=0);
    min=amin>=10?'$amin':'0$amin';
    sec=asec>=10?'$asec':'0$asec';
    mili=amili>=10?'$amili':'0$amili';
  }
}
class HourMin{
  int _hour;
  int _min;
  get hour => _hour;
  get min => _min;
  HourMin(this._hour,this._min);
}