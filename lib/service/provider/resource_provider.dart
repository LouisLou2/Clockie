import 'package:flutter/Material.dart';
import 'package:tuple/tuple.dart';

class ResourceProvider with ChangeNotifier {
  List<Tuple2<String,String>>musicGenre=[
    const Tuple2("Electronic", "electronic.jpg"),
    const Tuple2("Progress Rock", "progress_rock.jpg"),
    const Tuple2("Experimental Pop", "experimental_pop.jpg"),
    const Tuple2("Jazz", "jazz.jpg"),
    const Tuple2("R&B", "rnb.jpg"),
    const Tuple2("Folk", "folk.jpg"),
    const Tuple2("Folk Rock", "folk_rock.jpg"),
    const Tuple2("Classical", "classical.jpg")];
}