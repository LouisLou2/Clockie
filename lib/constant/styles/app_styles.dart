import 'dart:ui';

import 'package:flutter/material.dart';

class AppStyles {
  static const Color softWhite = Color(0xffFAFAF7);
  static const Color blueColor = Color(0xff55BEC0);
  static const Color backGroundColor = Color(0xff0E0E0E);
  static const Color cardColor = Color(0xff2E2E2E);
  static const Color softAzure=Color(0xfff5fffa);
  static const TextStyle monoSpaceStyleMed= TextStyle(fontSize: 52,fontWeight: FontWeight.w600, fontFeatures: [FontFeature.tabularFigures()]);
  static const TextStyle numberMonoSpaceStyle = TextStyle(fontSize: 42,fontWeight: FontWeight.w600, fontFeatures: [FontFeature.tabularFigures()]);
  static const TextStyle tabTxtStyle =TextStyle(fontSize: 12,fontFamily: "Poppins",fontWeight: FontWeight.w500);
  static const TextStyle timeTxtStyleB = TextStyle(fontSize: 18,fontFamily: "Poppins",fontWeight: FontWeight.w600);
  static const TextStyle timeTxtStyleN = TextStyle(fontSize: 16,fontFamily: "Poppins",fontWeight: FontWeight.w500);
  static const TextStyle numberStyle = TextStyle(fontSize: 42,fontFamily: "Poppins",fontWeight: FontWeight.w600);
  static const TextStyle bigNumberStyle = TextStyle(fontSize: 56,fontFamily: "Poppins",fontWeight: FontWeight.w600);
  static const TextStyle clockStyle = TextStyle(fontSize: 36,fontFamily: "Poppins",fontWeight: FontWeight.w600);
  static const TextStyle subTxtStyle = TextStyle(fontSize: 14,fontFamily: "Poppins",fontWeight: FontWeight.w400);
  static const TextStyle darkTxtStyle = TextStyle(fontSize: 14,fontFamily: "Poppins",fontWeight: FontWeight.w500);
  static const TextStyle blueTxtStyle = TextStyle(fontSize: 14,fontFamily: "Poppins",fontWeight: FontWeight.w500);

  static const TextStyle h1Style = TextStyle(fontSize: 25,fontFamily: "Poppins",fontWeight: FontWeight.w600);
  static const TextStyle h2Style = TextStyle(fontSize: 20,fontFamily: "Poppins",fontWeight: FontWeight.w500);
  static const TextStyle h3Style = TextStyle(fontSize: 17,fontFamily: "Poppins",fontWeight: FontWeight.w500);
  static const TextStyle subTitleStyle = TextStyle(fontSize: 14,fontFamily: "Poppins",fontWeight: FontWeight.w500);

  static const TextStyle messageStyle = TextStyle(fontSize: 18,fontFamily: "Poppins",fontWeight: FontWeight.w500);
  static const TextStyle buttonTxt = TextStyle(color:Colors.black87,fontSize: 18,fontFamily: "Poppins",fontWeight: FontWeight.w600);

  static final BorderRadius genericButtonBorderRadius = BorderRadius.circular(25);
  static final BorderRadius genericCardBorderRadius = BorderRadius.circular(20);
}