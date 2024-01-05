import 'package:clockie/constant/styles/app_styles.dart';
import 'package:clockie/service/provider/stopwatch_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LapTimes extends StatefulWidget {
  const LapTimes({super.key});

  @override
  State<LapTimes> createState() => _LapTimesState();
}

class _LapTimesState extends State<LapTimes> {

  Consumer<StopWatchProvider> _lapTimesListView() => Consumer<StopWatchProvider>(
    builder:(context, value, child) => SizedBox(
      height: 230.h,
      width: 220.w,
      child: ListView.builder(
        itemCount: value.lapList.length,
        itemBuilder: (context, index) => SizedBox(height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${value.lapList[index].lapNumber}.",style: AppStyles.timeTxtStyleN),
              Text(value.lapList[index].lapTime,style: AppStyles.timeTxtStyleN),
            ],
          )
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Column(
        children: [
          SizedBox(width: 230.w,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Order",style: AppStyles.timeTxtStyleB),
                Text("Time",style: AppStyles.timeTxtStyleB),
              ],
            ),
          ),
         const Padding(
           padding: EdgeInsets.only(top:30),
           child:Divider(
             height:1,
             indent: 0,
             endIndent: 0,
             thickness: 2,
           ),
          ),
          _lapTimesListView(),
        ],
      ),
    );
  }
}