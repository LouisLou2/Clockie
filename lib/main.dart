import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'gui/page/main_page.dart';
import 'init_affairs.dart';

void main()async{
  await initMustBeforeRunApp();
  initNormally();
  runApp(const MyApp());
}