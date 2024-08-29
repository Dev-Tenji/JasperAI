import 'package:flutter/material.dart';
import 'package:jasper_ai/Applogic.dart';
import 'package:jasper_ai/FeedBack.dart';
import 'package:jasper_ai/HelpCenter.dart';
import 'package:jasper_ai/Setting.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

import 'package:toggle_switch/toggle_switch.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: CircleAvatar(
              radius: 50,
              child: Image.asset('assets/robo1.png'),
            ),
          ),
          Center(
            child: Column(
              children: [
                Text(
                  'Andy',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  '@Andy34',
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 15),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(PageAnimationTransition(
                  page: Settingpage(),
                  pageAnimationType: FadeAnimationTransition()));
            },
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          // Divider(
          //   thickness: 0.5,
          // ),
          SizedBox(
            height: 5,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(PageAnimationTransition(
                  page: Helpcenter(),
                  pageAnimationType: FadeAnimationTransition()));
            },
            leading: Icon(Icons.help),
            title: Text('Help Center'),
          ),
          // Divider(
          //   thickness: 0.5,
          // ),
          SizedBox(
            height: 5,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(PageAnimationTransition(
                  page: FeedBack(),
                  pageAnimationType: FadeAnimationTransition()));
            },
            leading: Icon(Icons.email),
            title: Text('Send us Feedback'),
          ),
          // Divider(
          //   thickness: 0.5,
          // ),
          SizedBox(
            height: 5,
          ),
          ListTile(
            onTap: () {
              Applogic.PopNotify2(context, 'Rate Us',
                  'if you like our app and wish to rate us click here');
            },
            leading: Icon(Icons.star),
            title: Text('Rate our App'),
          ),
          // Divider(
          //   thickness: 0.5,
          // ),
          SizedBox(
            height: 5,
          ),
          ListTile(
            onTap: () {
              Applogic.SignOut(context);
            },
            leading: Icon(Icons.exit_to_app),
            title: Text('Sign Out'),
          ),
          // Divider(
          //   thickness: 0.5,
          // ),
          SizedBox(
            height: 60,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 30, right: 40),
            child: ToggleSwitch(
              customIcons: [
                Icon(
                  Icons.light_mode_outlined,
                  color: Colors.white,
                ),
                Icon(
                  Icons.nightlight_outlined,
                  color: Colors.white,
                )
              ],
              minWidth: 90.0,
              cornerRadius: 20.0,
              activeBgColors: [
                [Colors.blue],
                [const Color.fromARGB(221, 24, 24, 24)]
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.white,
              inactiveFgColor: Colors.black,
              initialLabelIndex: 0,
              totalSwitches: 2,
              labels: ['light', 'Dark'],
              radiusStyle: true,
              onToggle: (index) {
                print('switched to: $index');
              },
            ),
          ),
        ],
      ),
    );
  }
}
