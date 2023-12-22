import 'package:clockie/gui/widget/world_clock/analog_clock_vault.dart';
import 'package:clockie/service/stream/time_stream.dart';
import 'package:clockie/util/time_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant/styles/app_styles.dart';
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

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyles.backGroundColor,
        elevation: 0,
        toolbarHeight: 350,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child:AnalogClockVault.getBlackAnalogClock(),
            ),
              // child: Image.asset("images/world_map.png",
              //     color: AppStyles.softWhite),
            const Align(
              alignment: Alignment.centerLeft,
              child:Padding(
                padding: EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    // Icon(Icons.access_time,color: AppStyles.softWhite,size: 20,),
                    Text(" Local Time",style: AppStyles.timeTxtStyleB,),
                  ],
                )
              ),
            ),
            ListTile(
              // leading: const Icon(Icons.access_time,color: AppStyles.softWhite,size: 37.5,),
              title: const ClockNowWidget(),
              subtitle: StreamBuilder(
                stream: TimeStream.getTimeStream(3),
                initialData: TimeUtil.getNativeDateStr(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)=>Text(TimeUtil.getNativeDateStr(),style: AppStyles.subTxtStyle),
              ),
              trailing: IconButton(onPressed:() {
                  Navigator.pushNamed(context, '/world_clock/select');
                },
                icon: const Icon(Icons.add,color: AppStyles.softWhite)
              ),
            ),
          ],
        ),
      ),
      body: const CityTimeList(),
    );
  }
}