import 'package:clockie/constant/styles/app_styles.dart';
import 'package:clockie/service/provider/penthhouse_provider.dart';
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

  Widget _lapTimesListView() =>  Selector<StopWatchProvider,int>(
    selector: (context,provider)=>provider.lapList.length,
    builder:(context, value, child) => SizedBox(
      height: 230.h,
      width: 220.w,
      child: ListView.builder(
        itemCount: value,
        itemBuilder: (context, index) {
          var sprov=PenthHouseProviders.stopWatchProvider;
          return SizedBox(height: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${sprov!.lapList[index].lapNumber}.",
                    style: AppStyles.timeTxtStyleN),
                Text(sprov.lapList[index].lapTime,
                    style: AppStyles.timeTxtStyleN),
              ],
            )
          );
        }
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
           padding: EdgeInsets.only(top:10),
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