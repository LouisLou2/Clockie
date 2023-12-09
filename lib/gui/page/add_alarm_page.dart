import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:clockie/dict/date_dict.dart';
import 'package:clockie/service/alarm_manager.dart';
import 'package:clockie/service/notification/notification_vault.dart';
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
  TextEditingController alarmNameController = TextEditingController();
  TextEditingController alarmDescController = TextEditingController();
  Widget _dayPicker() {
    final provider = Provider.of<AlarmProvider>(context);
    return SizedBox(
      height: 36,
      child: GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 40.w, mainAxisSpacing: 10, mainAxisExtent: 40),
        itemCount: 7,
        itemBuilder: (context, index) =>
            InkWell(
              onTap: () => provider.pickDay(index),
              child: AnimatedContainer(
                width: 36,
                duration: const Duration(milliseconds: 150),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: provider.alarmNowSetting.days[index] ?
                    AppStyles.blueColor : Colors.transparent
                ),
                child: Center(
                  child: Text(DateDict.shortDays[index],
                      style: provider.alarmNowSetting.days[index] ?
                      AppStyles.darkTxtStyle : AppStyles.subTxtStyle),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const AlarmTimePicker(),
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
              _dayPicker(),
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