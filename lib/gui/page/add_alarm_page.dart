import 'package:clockie/dict/date_dict.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constant/styles/app_styles.dart';
import '../../service/provider/alarm_provider.dart';
import '../widget/alarm/alarm_time_picker.dart';
import '../widget/button.dart';

class AddAlarmPage extends StatefulWidget
{
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
                      style: isSelect ?
                      AppStyles.darkTxtStyle : AppStyles.subTxtStyle),
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
          buttonQuietStyle(press:  () => Navigator.pop(context), label:"Cancel"),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          provider.editingAlarm?AlarmTimePicker(initialHour: provider.alarmNowSetting.hour,initialMinute: provider.alarmNowSetting.min):AlarmTimePicker(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            height: ScreenUtil().screenHeight / 3,
            decoration: BoxDecoration(
                color: AppStyles.cardColor,
                borderRadius: BorderRadius.circular(24)
            ),
            child: Column(children: [
              SizedBox(height: 24.h),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text("Days", style: AppStyles.subTxtStyle),
                IconButton(onPressed: () {},
                    icon: const Icon(Icons.calendar_month_outlined,
                        color: AppStyles.softWhite))
              ]),
              _dayPicker(id),
              TextField(
                style: const TextStyle(color: AppStyles.softWhite),
                controller: alarmNameController,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: AppStyles.softWhite),
                  labelText: 'Alarm Name', // 文本输入框上方的描述性标签
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppStyles.softWhite), // 修改下划线颜色
                  ),
                ),
              ),
              TextField(
                style: const TextStyle(color: AppStyles.softWhite),
                controller: alarmDescController,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: AppStyles.softWhite),
                  labelText: 'Description', // 文本输入框上方的描述性标签
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppStyles.softWhite), // 修改下划线颜色
                  ),
                ),
              ),
            ]),
          ),
          _operateButton()
        ],
      ),
    );
  }
}