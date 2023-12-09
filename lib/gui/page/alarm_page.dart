//create a normal page, no matter what the page is, because this is a unfinished page , I'll do it later
import 'package:clockie/gui/widget/generic/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../constant/styles/app_styles.dart';
import '../../model/alarm_model.dart';
import '../../repository/alarm_box.dart';
import '../../service/provider/alarm_provider.dart';
import '../widget/alarm/alarm_card.dart';
import '../widget/generic/empty_massage.dart';

class AlarmPage extends StatefulWidget
{
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> with AutomaticKeepAliveClientMixin{
  _alarmList() {
    return Selector<AlarmProvider,bool>(
      selector: (context,provider) => provider.isDataInited,
      builder: (BuildContext context, bool isDataInited, Widget? child)=>isDataInited?
      Selector<AlarmProvider,int>(
        selector: (context,provider) => provider.alarmNum,
        builder: (BuildContext context, int alarmNum, Widget? child){
          if(alarmNum==0)return const EmptyMessage(txt: "No Alarm");
          AlarmProvider prov=Provider.of<AlarmProvider>(context,listen:false);
          List<Alarm>alarmList=prov.alarmList;
          return ListView.builder(
            itemCount: alarmNum,
            itemBuilder: (context, index) => alarmCard(alarmList[index].id, context),
          );
        }
      )
      :
      loadingWidget(whileLoading: ()=>Provider.of<AlarmProvider>(context,listen: false).initData()),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppStyles.backGroundColor,
      appBar: AppBar(
        title: const Text("My Alarm",style: AppStyles.mediumBarStyle),
        backgroundColor: AppStyles.backGroundColor,
        elevation: 0,
        toolbarHeight: 70,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
            child: IconButton(
                onPressed: () => Navigator.pushNamed(context, '/alarm/add'),
                icon: const Icon(Icons.add,color: AppStyles.softWhite,size: 30,)
            ),
          ),
        ],
      ),
      body:_alarmList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyles.softWhite,
        onPressed: () => Navigator.pushNamed(context, '/alarm/add'),
        tooltip: 'Add Alarm',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}