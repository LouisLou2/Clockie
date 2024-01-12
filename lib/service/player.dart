import 'package:audioplayers/audioplayers.dart';
import 'package:clockie/constant/location_collection.dart';

class AudioPlayerManager{
  //不如让获得实例的方法自己去管理。
  static late Map<String,AudioPlayer> players;
  static String trailListenName='trailListen';
  static String alarmPlayName='alarmPlay';
  static void init(){
    players={};
    AudioCache.instance=AudioCache(prefix: LocationCollector.audioPrefix);
  }
  static AudioPlayer getInstance({required String name}){
    return players[name]!;
  }
  static AudioPlayer getNewInstance({required String name}){
    if(players.containsKey(name))dispose(name: name);
    var player=AudioPlayer();
    player.setReleaseMode(ReleaseMode.loop);
    players.addEntries([MapEntry(name, player)]);
    return player;
  }
  static void dispose({required String name}){
    players[name]?.dispose();
    players.remove(name);
  }
  static void disposeAll(){
    players.forEach((key, value) {
      value.dispose();
    });
    players.clear();
  }
}