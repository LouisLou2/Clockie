import 'package:clockie/service/provider/penthhouse_provider.dart';
import 'package:clockie/service/provider/theme_provider.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../constant/styles/app_styles.dart';
import '../widget/more_setting/custome_list_tile.dart';
import '../widget/more_setting/single_section.dart';

class MoreSettingPage extends StatefulWidget {
  const MoreSettingPage({super.key});

  @override
  _MoreSettingPageState createState() => _MoreSettingPageState();
}

class _MoreSettingPageState extends State<MoreSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("More Setting",style: AppStyles.h1Style),
        elevation: 0,
        toolbarHeight: 80,
      ),
      body:Center(
        child:Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child:ListView(
            children: [
              SingleSection(
                title: 'General',
                children: [
                  CustomListTile(
                      title:'Ringtone',
                      icon:Icons.music_note,
                      tapFunc: () => Navigator.pushNamed(context, '/alarm/more/ringtone'),
                    ),
                  CustomListTile(
                    title:'Timer Expiry Ringtone',
                    icon:Icons.music_note,
                    tapFunc: () => Navigator.pushNamed(context, '/alarm/more/ringtone'),
                  ),
                  const CustomListTile(
                    title:'Ringtone Volume',
                    icon:Icons.volume_up,
                  ),
                  CustomListTile(
                    title:'Ring Duration',
                    icon:Icons.access_time_rounded,
                    trailing: DropdownButton(
                      value: 1,
                      borderRadius: BorderRadius.circular(10),
                      onChanged: (value) {},
                      items: const [
                        DropdownMenuItem(
                          value: 1,
                          child: Text('1 min'),
                        ),
                        DropdownMenuItem(
                          value: 5,
                          child: Text('5 min'),
                        ),
                        DropdownMenuItem(
                          value: 10,
                          child: Text('10 min'),
                        ),
                        DropdownMenuItem(
                          value: 15,
                          child: Text('15 min'),
                        ),
                        DropdownMenuItem(
                          value: 10,
                          child: Text('20 min'),
                        ),
                        DropdownMenuItem(
                          value: 30,
                          child: Text('30 min'),
                        ),
                        DropdownMenuItem(
                          value: 100,
                          child: Text('Manual Off'),
                        ),
                      ],
                    ),
                  ),
                  ]
                ),
              SingleSection(
                  title: 'Fine Settings',
                  children: [
                    CustomListTile(
                        title: 'Vibrate on Ring',
                        icon: Icons.vibration,
                        trailing: CupertinoSwitch(value:true, onChanged: (value){}),
                    ),
                    CustomListTile(
                        title: "Upcoming Ring Notification",
                        icon:Icons.notification_add,
                        trailing: CupertinoSwitch(value:true, onChanged: (value){}),
                    ),
                    CustomListTile(
                      title: "No Ring on Legal Holidays",
                      icon:CupertinoIcons.volume_mute,
                      trailing: CupertinoSwitch(value:true, onChanged: (value){}),
                    ),
                  ]
              ),
              SingleSection(
                  title: 'Other Settings',
                  children: [
                    CustomListTile(
                      title: 'Theme',
                      icon:CupertinoIcons.paintbrush,
                      trailing: Selector<ThemeProvider,Tuple2<bool,bool>>(
                        selector:(context,prov)=>prov.themeSetting,
                        builder: (context, setting, child)=>DropdownButton(
                          value: setting.item2?2:(setting.item1?0:1),
                          borderRadius: BorderRadius.circular(10),
                          onChanged: (value)=>PenthHouseProviders.themeProvider?.changeTheme(value!, context),
                          items: const [
                            DropdownMenuItem(
                              value: 0,
                              child: Text('Light'),
                            ),
                            DropdownMenuItem(
                              value: 1,
                              child: Text('Dark'),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text('Follow System'),
                            ),
                          ],
                        ),

                      )
                    ),
                    const CustomListTile(
                      title: 'Update Legal Holidays',
                      icon: Icons.update),
                    const CustomListTile(
                        title: 'Open Source Notice',
                        icon: Icons.security
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
}