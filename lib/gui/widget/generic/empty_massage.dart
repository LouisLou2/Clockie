import 'package:flutter/material.dart';

import '../../../constant/styles/app_styles.dart';

class EmptyMessage extends StatelessWidget
{
  final String txt;

  const EmptyMessage({super.key, required this.txt});

  @override
  Widget build(BuildContext context) => Center(
    child: Text(txt,style: AppStyles.messageStyle),
  );
}