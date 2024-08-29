import 'package:flutter/material.dart';
import 'package:jasper_ai/ChatPage.dart';
import 'package:jasper_ai/HomeScreen.dart';
import 'package:jasper_ai/SavedPage.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  int index = 0;
  int wtw(int ee) {
    if (ee == 1) {
      return 1;
    }
    return ee;
  }

  bool rr = false;
  void SwitchPage() {
    setState(() {
      rr = !rr;
    });
  }

  void dtr() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      index = 0;
    });
  }

  List<Widget> pages = [Homescreen(), Chatpage(), Savedpage()];
  Widget Tpage(int any, BuildContext context) {
    if (any == 0) {
      return Homescreen();
    } else if (any == 2) {
      return Savedpage();
    }
    SwitchPage();
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      // body: rr ? Tpage(index, context) : pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
            // if (value == 1) {
            //   Navigator.of(context).push(PageAnimationTransition(
            //       page: Chatpage(),
            //       pageAnimationType: FadeAnimationTransition()));
            //   dtr();
            // }
          });
        },
        // backgroundColor: Color.fromARGB(255, 177, 216, 248),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border), label: 'Saved'),
        ],
      ),
    );
  }
}
