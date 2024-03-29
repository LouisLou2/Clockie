import 'package:clockie/constant/styles/style.dart';
import 'package:clockie/gui/widget/world_clock/analog_clock_vault.dart';
import 'package:clockie/service/stream/time_stream.dart';
import 'package:clockie/service/provider/theme_provider.dart';
import 'package:clockie/util/time_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/styles/app_styles.dart';
import '../../service/navigation/navigator_manager.dart';
import '../widget/generic/clock_now.dart';
import '../widget/world_clock/city_time_list.dart';

class WorldClockPage extends StatefulWidget {
  const WorldClockPage({super.key});

  @override
  State<WorldClockPage> createState() => _WorldClockPageState();

}
class _WorldClockPageState extends State<WorldClockPage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;
  Widget barWidgetSet(){
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 30),
              child:Selector<ThemeProvider,bool>(
                selector: (context,prov)=>prov.curTheme,
                builder:(context,value,child)=>AnalogClockVault.getBlackAnalogClock(
                  AnalogClockColorScheme.getHourHand(value),
                  AnalogClockColorScheme.getMinSecHand(value),
                  AnalogClockColorScheme.getBorder(value),
                  AnalogClockColorScheme.getTick(value),
                  AnalogClockColorScheme.getNumber(value),
                ),
              )
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child:Padding(
                padding: EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Text(" Local Time",style: AppStyles.timeTxtStyleB,),
                  ],
                )
            ),
          ),
          ListTile(
            title: const ClockNowWidget(),
            subtitle: StreamBuilder(
              stream: TimeStream.getTimeStream(3),
              initialData: TimeUtil.getNativeDateStr(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)=>Text(TimeUtil.getNativeDateStr(),style: AppStyles.subTxtStyle),
            ),
            trailing: IconButton(
              onPressed:() {Navigator.pushNamed(context, NavigatorManager.selectCityPath);},
              icon: const Icon(Icons.add_location_alt_outlined,size:30),
            ),
          ),
          const Divider(
            indent:18,
            endIndent: 18,
            color: Colors.black26, // 设置横线的颜色
            thickness: 20, // 设置横线的厚度
          ),
        ]
    );
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar:AppBar(
        surfaceTintColor: Colors.white54,
        elevation: 0,
        toolbarHeight: 350,
        title:barWidgetSet(),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child:CityTimeList(),
      ),
    );
  }
}