import 'package:clockie/gui/widget/generic/button.dart';
import 'package:clockie/gui/widget/stopwatch/digit_clock.dart';
import 'package:clockie/gui/widget/stopwatch/lap_times.dart';
import 'package:clockie/service/provider/stopwatch_provider.dart';
import 'package:clockie/service/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  Widget _stopWatchButtons() {
    StopWatchProvider sprov = Provider.of<StopWatchProvider>(context, listen: false);

    return Selector<StopWatchProvider, bool>(
        selector: (context, provider) => provider.isRunning,
        builder: (BuildContext context, bool isRunning, Widget?child) =>
        isRunning ?
        Selector<StopWatchProvider, bool>(
            selector: (context, provider) => provider.timerActive,
            builder: (BuildContext context, bool timerActive, Widget?child) =>
            timerActive ?
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Selector<ThemeProvider,bool>(
                  selector: (context,prov)=>prov.curTheme,
                  builder:(context,value,child)=>pauseIconButton(
                    theme: value,
                    onPressd: () => sprov.pause(),
                  ),
                ),
                Selector<ThemeProvider,bool>(
                  selector: (context,prov)=>prov.curTheme,
                  builder:(context,value,child)=>lapIconButton(
                    theme: value,
                    onPressd:() => sprov.addLap(),
                  ),
                ),
              ]
            ) : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Selector<ThemeProvider,bool>(
                    selector: (context,prov)=>prov.curTheme,
                    builder:(context,value,child)=>playIconButton(
                      theme:value,
                      onPressd: () => sprov.start(),
                    ),
                  ),
                  Selector<ThemeProvider,bool>(
                    selector: (context,prov)=>prov.curTheme,
                    builder:(context,value,child)=>resetIconButton(
                      theme: value,
                      onPressd: () => sprov.reset(),
                    ),
                  ),
                ]
            )
        )
        : Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Selector<ThemeProvider,bool>(
              selector: (context,prov)=>prov.curTheme,
              builder:(context,value,child)=>playIconButton(
                theme: value,
                onPressd: () => sprov.start(),
              ),
            ),
            //buttonExecuteStyle(press: () => prov.start(), label: 'Start'),
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 200,
            ),
            const StopWatchWidget(),
            lapsListWidget(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        height: 100.h,
        child: Align(alignment: Alignment.topCenter,child: _stopWatchButtons()),
      ),
    );
  }
}