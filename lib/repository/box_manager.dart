import 'package:hive/hive.dart';

class BoxManager{
  static const String alarmBoxName = 'alarm';
  static const String timeDiffBoxName = 'time_diff';
  static const String chosenCityBoxName = 'chosen_city';
  static const String settingBoxName = 'setting';
  static const String dataBaseName = 'clockie';
  static late final BoxCollection box_collection;
  init() async {
    box_collection= await BoxCollection.open(
    dataBaseName,
    {
    'alarm','world_clock'
    },
    path: './data',
    );
  }
}