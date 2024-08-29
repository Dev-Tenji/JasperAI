import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jasper_ai/Applogic.dart';
import 'package:jasper_ai/SavedPage.dart';
import 'package:jasper_ai/usermodels.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

class Settingpage extends StatefulWidget {
  const Settingpage({super.key});

  @override
  State<Settingpage> createState() => _SettingpageState();
}

class _SettingpageState extends State<Settingpage> {
  OverlayEntry? entry;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'Settings',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 150,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: CircleAvatar(
                    radius: 50,
                    child: Image.asset('assets/robo1.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Text(
                              'Madara Uchiha',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                            // SizedBox(
                            //   width: 2,
                            // ),
                            SizedBox(
                              width: 5,
                            ),
                            IconButton(
                              onPressed: () {
                                Applogic.UpdateInfo(context);
                              },
                              icon: Icon(Icons.edit),
                            ),
                            // IconButton(
                            //   onPressed: () => null,
                            //   icon: Icon(Icons.qr_code_scanner_outlined),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, left: 15),
                              child: GestureDetector(
                                  onTap: () {
                                    Applogic.QrCode(context);
                                  },
                                  child: Icon(
                                    Icons.qr_code_scanner_outlined,
                                    size: 30,
                                  )),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 90),
                        child: Text(
                          "Don't tell anyone that \nbut i'm obito uchiha brother",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          ListTile(
            onTap: () => Applogic.ShowOverlay(context, entry),
            leading: Icon(Icons.person_2_outlined),
            title: Text(
              'Account',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Privacy,Security,change email or password',
              style: TextStyle(fontSize: 10),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(PageAnimationTransition(
                  page: Savedpage(),
                  pageAnimationType: FadeAnimationTransition()));
            },
            leading: Icon(Icons.chat),
            title: Text(
              'Chats',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Theme, wallpapers, chat history',
              style: TextStyle(fontSize: 10),
            ),
          ),
          ListTile(
            leading: Icon(Icons.notifications_none_outlined),
            title: Text(
              'Notification',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'alert Messages and notification info   ',
              style: TextStyle(fontSize: 10),
            ),
          ),
          ListTile(
            leading: Icon(Icons.storage_outlined),
            title: Text(
              'Stroge and data',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'downloads and other storage info',
              style: TextStyle(fontSize: 10),
            ),
          ),
          ListTile(
            leading: Icon(Icons.support_agent_outlined),
            title: Text(
              'Help',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Contact us, privacy policy',
              style: TextStyle(fontSize: 10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 160, bottom: 35),
            child: TextButton(
              onPressed: () => null,
              child: Text('Invite a friend'),
            ),
          )
        ],
      ),
    );
  }
}
