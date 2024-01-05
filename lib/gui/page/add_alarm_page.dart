import 'package:clockie/dict/date_dict.dart';
import 'package:clockie/service/provider/penthhouse_provider.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constant/styles/app_styles.dart';
import '../../service/provider/alarm_provider.dart';
import '../widget/alarm/alarm_time_picker.dart';
import '../widget/generic/button.dart';

class AddAlarmPage extends StatefulWidget {
  const AddAlarmPage({super.key});

  @override
  State<AddAlarmPage> createState() => _AddAlarmPageState();
}

class _AddAlarmPageState extends State<AddAlarmPage> {
  late TextEditingController alarmNameController;
  late TextEditingController alarmDescController;

  Widget _dayPicker(String? id) {
    final provider = Provider.of<AlarmProvider>(context, listen: false); //当前节点不订阅，只是获取
    return SizedBox(
      height: 36,
      child: GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 40.w, mainAxisSpacing: 10, mainAxisExtent: 40),
        itemCount: 7,
        itemBuilder: (context, index) =>Selector<AlarmProvider,bool>(
            selector:(context,provider) => provider.alarmNowSetting.days[index],
            builder:(context,isSelect,child)=>InkWell(
              onTap: () => provider.pickDay(index),
              child: AnimatedContainer(
                width: 36,
                duration: const Duration(milliseconds: 150),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: isSelect ?
                    AppStyles.blueColor : Colors.transparent
                ),
                child: Center(
                  child: Text(DateDict.shortDays[index],
                      style: isSelect ? AppStyles.darkTxtStyle : AppStyles.subTxtStyle),
                ),
              ),
            ),
        ),
      ),
    );
  }
  Widget _operateButton() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buttonQuietStyle(press:  (){
            //这个giveupEditing本来是给正在编辑的闹钟使用的，表示放弃编辑，但就这吧，即使是先闹钟cancel也没事，就赋值个false，没关系
            PenthHouseProviders.alarmProvider!.giveupEditing();
            Navigator.pop(context);
          }, label:"Cancel"),
          buttonExecuteStyle(press:() => _setAlarm(), label:"Save"),
        ]
    );
  }
  _setAlarm() {
    final provider = Provider.of<AlarmProvider>(context, listen: false); //当前节点不订阅，只是获取
    provider.setNowAlarmNameAndDesc(alarmNameController.text, alarmDescController.text);
    provider.submitAlarm();
    Navigator.pop(context);
  }
  _initTextEditingController({String? name, String? desc}) {
    alarmNameController = TextEditingController(text: name??'');
    alarmDescController = TextEditingController(text: desc??'');
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AlarmProvider>(context, listen: false); //当前节点不订阅，只是获取
    final id = ModalRoute.of(context)!.settings.arguments as String?;
    if(id!=null){
      provider.alarmNowSettingWithExisting(id);
      _initTextEditingController(
          name:provider.alarmNowSetting.name,
          desc:provider.alarmNowSetting.desc
      );
    }else{
      _initTextEditingController();
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Set Alarm",style: AppStyles.h1Style,),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            height: ScreenUtil().screenHeight / 3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24)
            ),
            child: Column(
                children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Days", style: AppStyles.h2Style),
                    IconButton(onPressed: () {},
                        icon: const Icon(Icons.calendar_month_outlined,size:30))
                  ]
              ),
              _dayPicker(id),
              TextField(
                controller: alarmNameController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top:30,bottom: 10),
                  labelStyle: AppStyles.h2Style,
                  labelText: 'Alarm Name', // 文本输入框上方的描述性标签
                ),
              ),
              TextField(
                controller: alarmDescController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top:30,bottom: 10),
                  labelStyle: AppStyles.h2Style,
                  labelText: 'Description', // 文本输入框上方的描述性标签
                ),
              ),
            ]),
          ),
          provider.editingAlarm?AlarmTimePicker(initialHour: provider.alarmNowSetting.hour,initialMinute: provider.alarmNowSetting.min):const AlarmTimePicker(),
          _operateButton()
        ],
      ),
    );
  }
}