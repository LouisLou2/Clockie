import 'package:clockie/service/provider/timer_provider.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../../constant/styles/app_styles.dart';
import '../../../util/formattor.dart';

class TimerIndicator extends StatelessWidget
{
  final double height, width;
  const TimerIndicator({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) => SizedBox(
    height: height,
    width: width,
    child: Stack(
      fit: StackFit.expand,
      children: [
        Center(child:Selector<TimerProvider,int>(
                  selector: (context, provider) => provider.secLeft,
                  builder: (context, value, child) => Text(
                      DateFormatter.getTimeStrFromSecond(value),
                      style: AppStyles.numberMonoSpaceStyle,
                  ),
                ),
              ),
          Selector<TimerProvider,double>(
            selector: (context, provider) => provider.percent,
            builder: (context, percent, child) => CircularProgressIndicator(
              strokeWidth: 6,
              backgroundColor: Colors.black,
              valueColor: const AlwaysStoppedAnimation(AppStyles.blueColor),
              value: percent,
            ),
          ),
      ],
    )
  );
}