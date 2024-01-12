import 'package:audioplayers/audioplayers.dart';
import 'package:clockie/constant/location_collection.dart';

class GlobalAudioPlayer{
  static late AudioPlayer instance;
  static void init(){
    AudioCache.instance=AudioCache(prefix: LocationCollector.audioPrefix);
    instance=AudioPlayer();
    instance.setReleaseMode(ReleaseMode.loop);
  }
  static void dispose(){
    instance.dispose();
  }
}