import 'package:clockie/constant/styles/app_styles.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';

class CustomListTile extends StatelessWidget{
  const CustomListTile({super.key, required this.title, required this.icon, this.trailing,this.tapFunc});
  final String title;
  final IconData icon;
  final Widget? trailing;
  final void Function()?tapFunc;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title:Text(title,style: AppStyles.h2Style,),
      leading:Icon(icon),
      trailing:trailing??const Icon(CupertinoIcons.forward,size:18),
      onTap:tapFunc??(){},
    );
  }

}