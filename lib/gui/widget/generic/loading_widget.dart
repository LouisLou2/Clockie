import 'package:flutter/Material.dart';

import '../../../constant/styles/app_styles.dart';

Widget loadingWidget({String? txt,required Function whileLoading}){
  whileLoading();
  return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        const CircularProgressIndicator(
          color: AppStyles.blueColor,
        ),
        const SizedBox(height: 12,),
        Text(txt??'',style: AppStyles.subTxtStyle,)
      ],
    ),
  );
}