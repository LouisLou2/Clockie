import 'package:clockie/service/stream/time_stream.dart';
import 'package:clockie/util/time_util.dart';
import 'package:flutter/Material.dart';
import 'package:intl/intl.dart';

import '../../../constant/styles/app_styles.dart';

class ClockNowWidget extends StatelessWidget {
  const ClockNowWidget({super.key});

  @override
  Widget build(BuildContext context) => StreamBuilder(
    stream: TimeStream.getTimeStream(0),
    builder: (context, snapshot) => Text(
      DateFormat('HH:mm:ss').format(DateTime.now()),
      style: AppStyles.clockStyle,
    ),
  );
}