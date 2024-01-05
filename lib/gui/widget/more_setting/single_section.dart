import 'package:clockie/constant/styles/app_styles.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';

class SingleSection extends StatelessWidget{
  String title;
  final List<Widget>children;
  SingleSection({super.key,required this.title,required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding:const EdgeInsets.fromLTRB(15, 8, 9, 10),
              child:Text(
                title,
                style:AppStyles.h2Style,
              )
          ),
          const Divider(
            height: 1,
            thickness: 1,
            indent: 15,
            endIndent: 15,
          ),
          SizedBox(
              width:double.infinity,
              child:Column(
                children: children,
              )
          ),
        ],
      )
    );
  }
}