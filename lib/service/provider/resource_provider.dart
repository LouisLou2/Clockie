import 'package:audioplayers/audioplayers.dart';
import 'package:clockie/repository/setting_box.dart';
import 'package:clockie/service/player.dart';
import 'package:flutter/Material.dart';
import 'package:tuple/tuple.dart';

class ResourceProvider with ChangeNotifier {
  List<Tuple3<String,String,String>>musicGenre=[
    const Tuple3("Electronic", "electronic.jpg","PastLife-Currents.mp3"),
    const Tuple3("Progress Rock", "progress_rock.jpg","Clean-1989.mp3"),
    const Tuple3("Experimental Pop", "experimental_pop.jpg","Clean-1989.mp3"),
    const Tuple3("Jazz", "jazz.jpg","Clean-1989.mp3"),
    const Tuple3("R&B", "rnb.jpg","Clean-1989.mp3"),
    const Tuple3("Folk", "folk.jpg","seven-folklore.mp3"),
    const Tuple3("Folk Rock", "folk_rock.jpg","Clean-1989.mp3"),
    const Tuple3("Classical", "classical.jpg","Clean-1989.mp3")];
  int ringtoneIndex=-1;

  void init(){
    ringtoneIndex=SettingBox.getRingtoneChosen()!;
  }

  void chooseRingtone(int index)async{
    if(index==ringtoneIndex)return;
    ringtoneIndex=index;
    SettingBox.setRingtoneChosen(index);
    await GlobalAudioPlayer.instance.stop();
    GlobalAudioPlayer.instance.play(AssetSource(musicGenre[index].item3));
    notifyListeners();
  }
}