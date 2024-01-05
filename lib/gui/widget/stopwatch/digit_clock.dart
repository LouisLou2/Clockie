import 'package:clockie/constant/styles/app_styles.dart';
import 'package:clockie/service/provider/stopwatch_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class StopWatchWidget extends StatefulWidget {
  const StopWatchWidget({super.key});

  @override
  State<StopWatchWidget> createState() => _StopWatchWidgetState();
}

class _StopWatchWidgetState extends State<StopWatchWidget> {
  @override
  Widget build(BuildContext context)=>Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 分钟数字
          Expanded(child: Padding(
            padding: const EdgeInsets.all(5),
            child:Selector<StopWatchProvider,int>(
              selector: (context,provider)=>provider.min,
              builder: (context,min,child)=>Text(
                '${min<10?'0$min':min}',
                textAlign: TextAlign.center,
                style: AppStyles.monoSpaceStyleMed,
              ),
              ),
            ),
          ),
          const Text(
            ':',
            style: AppStyles.bigNumberStyle,
          ),
          Expanded(child: Padding(
              padding: const EdgeInsets.all(5),
              child:Selector<StopWatchProvider,int>(
                selector: (context,provider)=>provider.sec,
                builder: (context,sec,child)=>Text(
                  '${sec<10?'0$sec':sec}',
                  textAlign: TextAlign.center,
                  style: AppStyles.monoSpaceStyleMed,
                ),
              ),
            ),
          ),
          const Text(
            ':',
            style: AppStyles.bigNumberStyle,
          ),
          // 毫秒数字
          Expanded(child: Padding(
              padding: const EdgeInsets.all(5),
              child:Selector<StopWatchProvider,int>(
                selector: (context,provider)=>provider.mili,
                builder: (context,mili,child)=>Text(
                  '${mili<10?'0$mili':mili}',
                  textAlign: TextAlign.center,
                  style: AppStyles.monoSpaceStyleMed,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }