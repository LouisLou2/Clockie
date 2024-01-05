//create a normal page, no matter what the page is, because this is a unfinished page , I'll do it later
import 'package:clockie/gui/widget/generic/custom_button.dart';
import 'package:clockie/gui/widget/generic/custom_alert.dart';
import 'package:clockie/gui/widget/generic/loading_widget.dart';
import 'package:clockie/service/provider/penthhouse_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/styles/app_styles.dart';
import '../../model/alarm_model.dart';
import '../../service/provider/alarm_provider.dart';
import '../widget/alarm/alarm_card.dart';
import '../widget/generic/bottom_oper.dart';
import '../widget/generic/empty_massage.dart';

class AlarmPage extends StatefulWidget {
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
          return ListView.builder(
            itemCount: alarmNum,
            itemBuilder: (context, index) => alarmCard(index, context),
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
      appBar: AppBar(
        title: Column(
          children:[
            const Text("Alarms",style: AppStyles.h1Style,),
            Selector<AlarmProvider,bool>(
              selector: (context,prov)=>prov.shouldRing,
              builder: (context,value,child){
                if(!value){
                  return const SizedBox.shrink();
                }
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  // 使用addPostFrameCallback确保Dialog在build完成后显示，避免可能的问题
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      String alarmId=PenthHouseProviders.alarmProvider!.alarmNowRinging;
                      Alarm alarm=PenthHouseProviders.alarmProvider!.getAlarm(alarmId);
                      PenthHouseProviders.alarmProvider!.shutDownAlarm();
                      return alarmDialog(context,alarm.name!=""?alarm.name:"Untitled Alarm",alarm.desc!=""?alarm.desc:"No Description");
                    },
                  );
                });
                return const SizedBox.shrink();
              },
            )
          ]
        ),
        elevation: 0,
        toolbarHeight: 70,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
            child: IconButton(
              onPressed: (){
                bool selecting=PenthHouseProviders.alarmProvider!.selecting;
                if(!selecting&&PenthHouseProviders.alarmProvider!.alarmNum==0){
                  showSimpleSnackBar(context, 'No Alarm to Be Edited');
                  return;
                }
                PenthHouseProviders.alarmProvider!.changeSelecting();
              },
              icon: Selector<AlarmProvider,bool>(
                selector: (context,prov)=>prov.selecting,
                builder: (context,value,child)=>value?const Icon(CupertinoIcons.check_mark,size: 30,):const Icon(CupertinoIcons.pen,size: 30,)
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
            child: IconButton(
                onPressed: () => Navigator.pushNamed(context, '/alarm/more'),
                icon: const Icon(Icons.more_vert,size: 30,)
            ),
          ),
        ],
      ),
      body:Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            _alarmList(), //这里是列表的内容
            getBottomOperationBar(), //这里是底部删除全选操作的内容
          ],
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: getFloatingButton(
          theme:PenthHouseProviders.themeProvider!.curTheme,
          onPressd: () => Navigator.pushNamed(context, '/alarm/add'),
          icon:const Icon(Icons.add),
          toolTip: 'Add Alarm',
          circle: false),
    );
  }
  @override
  bool get wantKeepAlive => true;
}