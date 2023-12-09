import 'package:clockie/service/provider/world_clock_provider.dart';
import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';
import 'package:clockie/gui/widget/generic/loading_widget.dart';
import 'city_time_card.dart';

class CityTimeList extends StatefulWidget {
  const CityTimeList({super.key});
  @override
  State<CityTimeList> createState() => _CityTimeListState();
}

class _CityTimeListState extends State<CityTimeList> {
  @override
  Widget build(BuildContext context) {
    WorldClockProvider prov = Provider.of<WorldClockProvider>(context,listen: false);
    return Selector<WorldClockProvider,bool>(
      selector:(context,provider) => provider.isDataInited,
      builder:(context,isDataInited,child){
        return isDataInited ?
        Selector<WorldClockProvider,int>(
            selector:(context,provider) => provider.citiesNum,
            builder:(context,citiesNum,child){
              List<String> timezoneList = prov.timezonesList;
              return ListView.builder(
                itemCount: citiesNum,
                itemBuilder: (context,index) => cityTimeCard(context,timezoneList[index]),
              );
            }
        )
        :
        loadingWidget(whileLoading: () => prov.initData());
      }
    );
  }
}