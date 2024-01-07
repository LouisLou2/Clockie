import 'package:clockie/cleanup_affairs.dart';
import 'package:clockie/constant/app_properties.dart';
import 'package:clockie/constant/styles/style.dart';
import 'package:clockie/global_context.dart';
import 'package:clockie/gui/page/stopwatch_page.dart';
import 'package:clockie/service/navigation/navigator_manager.dart';
import 'package:clockie/service/provider/penthhouse_provider.dart';
import 'package:clockie/service/provider/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

class MyApp extends StatefulWidget{//WidgetsBindingObserver用于监听生命周期,直接在main函数中runApp之后执行是不行的
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState ();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{
  bool firstLaunch=true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@addPostFrameCallback");
    });
    var dispatcher = SchedulerBinding.instance.platformDispatcher;
    // This callback is called every time the brightness changes.
    dispatcher.onPlatformBrightnessChanged = () {
      print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@onPlatformBrightnessChanged");
    };
  }
  @override
  void didChangePlatformBrightness() {
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@didChangePlatformBrightness");
    super.didChangePlatformBrightness();
    PenthHouseProviders.themeProvider!.onPlatFormBrightnessChange();
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    cleanUp();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: PenthHouseProviders.alarmProvider),
      ChangeNotifierProvider.value(value: PenthHouseProviders.worldClockProvider),
      ChangeNotifierProvider.value(value:PenthHouseProviders.stopWatchProvider),
      ChangeNotifierProvider.value(value:PenthHouseProviders.timerProvider),
      ChangeNotifierProvider.value(value: PenthHouseProviders.themeProvider),
      ChangeNotifierProvider.value(value: PenthHouseProviders.resourceProvider),
      ChangeNotifierProvider.value(value: PenthHouseProviders.settingsProvider),
    ],
    child: ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => Selector<ThemeProvider,bool>(
        selector: (context,prov)=>prov.curTheme,
        builder: (context, value, Widget? child) {
          GlobalContext.appContext=context;
          if(firstLaunch&&PenthHouseProviders.themeProvider!.withSys){
            firstLaunch=false;
            value=MediaQuery.platformBrightnessOf(context)==Brightness.light;
            PenthHouseProviders.themeProvider!.curTheme=value;
          }
          //PenthHouseProviders.themeProvider!.changeNavbar();
          return MaterialApp(
            title: AppProperties.APP_NAME,
            debugShowCheckedModeBanner: false,
            theme: ThemeVault.getThemeByBrightness(value),
            home: const Tab(),
            routes: NavigatorManager.routes, //注册路由表
          );
        }
      ),
    ),
  );
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed){
        PenthHouseProviders.worldClockProvider!.changeResumeJustNow();
    }
    super.didChangeAppLifecycleState(state);
  }
}


class Tab extends StatelessWidget{
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
          padding: const EdgeInsets.symmetric(vertical: 0),
          labelColor: AppStyles.blueColor,
          labelStyle: AppStyles.tabTxtStyle,
          splashBorderRadius: BorderRadius.circular(10),
          indicatorColor: AppStyles.blueColor,
          indicatorPadding: const EdgeInsets.all(0),// 可能需要将指示器的边距设置为零
          tabs: const [
            Icon(CupertinoIcons.alarm),
            Icon(CupertinoIcons.globe),
            Icon(CupertinoIcons.stopwatch),
            Icon(CupertinoIcons.timer),
          ],
          dividerColor: Colors.transparent,
        ),
      ),
    );
  }
}