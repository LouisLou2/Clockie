import 'package:clockie/service/provider/timer_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widget/button.dart';
import '../widget/timer/timer_indicator.dart';
import '../widget/timer/timer_time_picker.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;


  Widget _timerButtonGroup(){
    TimerProvider prov=Provider.of<TimerProvider>(context,listen: false);
    return Selector<TimerProvider,bool>(
      selector:(context,provider)=>provider.isRunning,
      builder:(BuildContext context, bool isRunning,Widget?child)=>
        Row(
          mainAxisAlignment:MainAxisAlignment.spaceEvenly,
          children: isRunning ? [
            Selector<TimerProvider,bool>(
                selector: (context,provider)=>provider.timerActive,
                builder:(BuildContext context,bool timerActive,Widget?child) =>
                    timerActive?buttonMaimStyle(press: ()=>prov.countingStateChange(),label: 'Pause')
                        :buttonExecuteStyle(press: ()=>prov.countingStateChange(),label: 'Continue'),
            ),
            buttonQuietStyle(press: ()=>prov.reset(),label: 'Finish'),
          ]:[
            buttonExecuteStyle(press: ()=>prov.start(),label: 'Start'),
          ]
       )
    );
  }
  Widget _overlayCheck(){
    TimerProvider prov=Provider.of<TimerProvider>(context);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: Selector<TimerProvider,bool>(
        selector: (context,provider)=>provider.isRunning,
        builder:(BuildContext context, bool isRunning,Widget?child)=>prov.isRunning ?
        TimerIndicator(height: 0.8.sw, width: 0.8.sw) :
        const TimerTimePicker(),
      )
    );
  }
  @override
  Widget build(BuildContext context) {

    super.build(context);

    return Scaffold(
      body: Center(
        child:_overlayCheck(),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        height: 150.h,
        child: _timerButtonGroup(),
      )
    );
  }
}