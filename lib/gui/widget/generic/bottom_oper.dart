import 'package:clockie/constant/styles/app_styles.dart';
import 'package:clockie/service/provider/alarm_provider.dart';
import 'package:clockie/service/provider/penthhouse_provider.dart';
import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';
Widget getBottomOperationBar(){
  return Selector<AlarmProvider,bool>(
    selector: (context,prov)=>prov.selecting,
    builder: (context,value,child){
      return Offstage(
        offstage: !value,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Container(
            decoration: const BoxDecoration(
              color: AppStyles.blueColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Selector<AlarmProvider,bool>(
                        selector: (context,prov)=>prov.selectAllCheck,
                        builder:(context,value,child)=>Checkbox(
                          value: value,
                          onChanged: (value) {
                            PenthHouseProviders.alarmProvider!.selectAllOrNot(value!);
                          },
                          checkColor: Colors.white,
                          activeColor: AppStyles.blueColor,
                        ),
                      ),
                      const Text('Select All',style: AppStyles.subTitleStyle),
                    ],
                  ),
                  InkWell(
                    child:IconButton(
                      onPressed:  ()=>PenthHouseProviders.alarmProvider!.deletedSelected(),
                      icon: const Icon(Icons.delete,size: 30,color: Colors.white,),
                    ),
                  ),
                ],
              )),
        ),
      );
    },
  );
}