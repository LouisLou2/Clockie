import 'package:clockie/cleanup_affairs.dart';
import 'package:clockie/gui/page/stopwatch_page.dart';
import 'package:clockie/service/navigation/navigator_manager.dart';
import 'package:clockie/service/provider/penthhouse_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clockie/constant/styles/app_styles.dart';
import 'gui/page/alarm_page.dart';
import 'gui/page/timer_page.dart';
import 'gui/page/world_clock_page.dart';
import 'init_affairs.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main()async{
  await initMustBeforeRunApp();
  initNormally();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget with WidgetsBindingObserver {//WidgetsBindingObserver用于监听生命周期,直接在main函数中runApp之后执行是不行的
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: PenthHouseProviders.alarmProvider),
        ChangeNotifierProvider.value(value: PenthHouseProviders.worldClockProvider),
        ChangeNotifierProvider.value(value:PenthHouseProviders.stopWatchProvider),
        ChangeNotifierProvider.value(value:PenthHouseProviders.timerProvider),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 640),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) =>  MaterialApp(
          title: 'Clockie',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              scaffoldBackgroundColor: AppStyles.backGroundColor
          ),
          home: const Tab(),
          routes: NavigatorManager.routes,//注册路由表
        ),
      ),
    );
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      cleanUp();
    }
    super.didChangeAppLifecycleState(state);
  }
}

class Tab extends StatelessWidget {
  const Tab({super.key});

  Widget tabTxt(txt) => Text(txt,textAlign: TextAlign.center);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        body: const TabBarView(
          //physics: ClampingScrollPhysics(),控制滑动逻辑
          children: [
            AlarmPage(),
            WorldClockPage(),
            StopwatchPage(),
            TimerPage(),
          ],
        ),
        bottomNavigationBar: TabBar(
          labelPadding: const EdgeInsets.all(10),
          //padding: const EdgeInsets.symmetric(vertical: 12),
          labelColor: AppStyles.blueColor,
          labelStyle: AppStyles.tabTxtStyle,
          unselectedLabelColor: AppStyles.softWhite,
          splashBorderRadius: BorderRadius.circular(30),
          indicatorColor: AppStyles.blueColor,
          indicatorPadding: const EdgeInsets.all(0), // 可能需要将指示器的边距设置为零
          tabs: [
            tabTxt("Alarm"),
            tabTxt('World Clock'),
            tabTxt('StopWatch'),
            tabTxt('Timer'),
          ],
          dividerColor: Colors.transparent,
        ),
      ),
    );
  }
}