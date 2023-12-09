import 'package:clockie/dict/worldtime_dict.dart';
import 'package:clockie/gui/widget/generic/loading_widget.dart';
import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';

import '../../constant/styles/app_styles.dart';
import '../../service/provider/world_clock_provider.dart';
import '../widget/world_clock/city_time_card_simple.dart';

class SelectCityPage extends StatelessWidget {
  const SelectCityPage({super.key});

  @override
  Widget build(BuildContext context)=> Scaffold(
    appBar: AppBar(
      iconTheme: const IconThemeData(color: AppStyles.softWhite),
      backgroundColor: AppStyles.backGroundColor,
      elevation: 0,
      toolbarHeight: 70,
      title: Text("Select City",style: AppStyles.timeTxtStyleB),
    ),
    body: _cityList(context),
  );
}

Widget _cityList(BuildContext context) {
  WorldClockProvider prov = Provider.of<WorldClockProvider>(context,listen: false);
  /*这里假设的就是WorldTimeDict.timeDiffDictAsList就是恒久不变的，所以这样独立的获取是可以的，它永远不会被更新
  * */
  return Selector<WorldClockProvider,bool>(
    selector: (BuildContext context,WorldClockProvider provider)=>provider.isDictInited,
    builder: (BuildContext context, bool isDictInited, Widget? child){
      if(!isDictInited){
        return loadingWidget(whileLoading: ()=>prov.initWorldClockDict());
      }
      List<String> diffList = WorldTimeDict.timeDiffDictAsList;
      return ListView.builder(
        itemCount: diffList.length,
        itemBuilder: (context, index) => cityTimeSimpleCard(
          timezone:diffList[index],
          ontap:(String zone){prov.selectCity(zone);Navigator.pop(context);},
        ),
      );
    },
  );
}