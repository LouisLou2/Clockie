import 'dart:ui';

import 'package:flutter/material.dart';

class AppStyles {
  static const Color softWhite = Color(0xffE3E3E3);
  static const Color blueColor = Color(0xff55BEC0);
  static const Color backGroundColor = Color(0xff0E0E0E);
  static const Color cardColor = Color(0xff2E2E2E);
  static const TextStyle monoSpaceStyleMed= TextStyle(color: softWhite,fontSize: 52,fontWeight: FontWeight.w600, fontFeatures: [FontFeature.tabularFigures()]);
  static const TextStyle numberMonoSpaceStyle = TextStyle(color: softWhite,fontSize: 42,fontWeight: FontWeight.w600, fontFeatures: [FontFeature.tabularFigures()]);
  static const TextStyle tabTxtStyle =TextStyle(color: softWhite,fontSize: 12,fontFamily: "Poppins",fontWeight: FontWeight.w500);
  static const TextStyle mediumBarStyle = TextStyle(color: softWhite,fontSize: 25,fontFamily: "Poppins",fontWeight: FontWeight.w500);
  static const TextStyle timeTxtStyleB = TextStyle(color: softWhite,fontSize: 18,fontFamily: "Poppins",fontWeight: FontWeight.w600);
  static const TextStyle timeTxtStyleN = TextStyle(color: softWhite,fontSize: 16,fontFamily: "Poppins",fontWeight: FontWeight.w500);
  static const TextStyle numberStyle = TextStyle(color: softWhite,fontSize: 42,fontFamily: "Poppins",fontWeight: FontWeight.w600);
  static const TextStyle bigNumberStyle = TextStyle(color: softWhite,fontSize: 56,fontFamily: "Poppins",fontWeight: FontWeight.w600);
  static const TextStyle clockStyle = TextStyle(color: softWhite,fontSize: 36,fontFamily: "Poppins",fontWeight: FontWeight.w600);
  static const TextStyle subTxtStyle = TextStyle(color: softWhite,fontSize: 14,fontFamily: "Poppins",fontWeight: FontWeight.w400);
  static const TextStyle darkTxtStyle = TextStyle(color: backGroundColor,fontSize: 14,fontFamily: "Poppins",fontWeight: FontWeight.w500);
  static const TextStyle blueTxtStyle = TextStyle(color: blueColor,fontSize: 14,fontFamily: "Poppins",fontWeight: FontWeight.w500);

  static const TextStyle titleStyle = TextStyle(color: softWhite,fontSize: 20,fontFamily: "Poppins",fontWeight: FontWeight.w600);
  static const TextStyle subTitleStyle = TextStyle(color: softWhite,fontSize: 14,fontFamily: "Poppins",fontWeight: FontWeight.w500);

  static const TextStyle messageStyle = TextStyle(color: softWhite,fontSize: 18,fontFamily: "Poppins",fontWeight: FontWeight.w500);
  static const TextStyle buttonTxt = TextStyle(color: backGroundColor,fontSize: 18,fontFamily: "Poppins",fontWeight: FontWeight.w600);

  static final BorderRadius genericButtonBorderRadius = BorderRadius.circular(25);
  static final BorderRadius genericCardBorderRadius = BorderRadius.circular(20);
}