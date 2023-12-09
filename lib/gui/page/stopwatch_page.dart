import 'package:clockie/constant/styles/app_styles.dart';
import 'package:clockie/gui/widget/stopwatch/digit_clock.dart';
import 'package:clockie/gui/widget/stopwatch/lap_times.dart';
import 'package:clockie/service/provider/stopwatch_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clockie/gui/widget/button.dart';
class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  Widget _stopWatchButtons() {
    StopWatchProvider prov = Provider.of<StopWatchProvider>(context, listen: false);

    return Selector<StopWatchProvider, bool>(
        selector: (context, provider) => provider.isRunning,
        builder: (BuildContext context, bool isRunning, Widget?child) =>
        isRunning ?
        Selector<StopWatchProvider, bool>(
            selector: (context, provider) => provider.timerActive,
            builder: (BuildContext context, bool timerActive, Widget?child) =>
            timerActive ?
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buttonMaimStyle(press: () => prov.pause(), label: 'Pause'),
                  buttonQuietStyle(press: () => prov.addLap(), label: 'Lap'),
                ]
            ) : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buttonExecuteStyle(
                      press: () => prov.start(), label: 'Continue'),
                  buttonQuietStyle(press: () => prov.reset(), label: 'Reset'),
                ]
            )
        )
        : Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buttonExecuteStyle(press: () => prov.start(), label: 'Start'),
          ]
        )
    );
  }

  Widget lapsListWidget() => Consumer<StopWatchProvider>(
    builder:(context, value, child) => Visibility(
        visible: value.lapList.isEmpty ? false : true,
        child: const LapTimes()
    ),
  );

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const StopWatchWidget(),
            lapsListWidget(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        height: 100.h,
        child: Align(alignment: Alignment.topCenter,child: _stopWatchButtons()),
      ),
    );
  }
}