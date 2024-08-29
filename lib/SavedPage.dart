import 'package:flutter/material.dart';
import 'package:jasper_ai/bottomNav.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

class Savedpage extends StatefulWidget {
  const Savedpage({super.key});

  @override
  State<Savedpage> createState() => _SavedpageState();
}

class _SavedpageState extends State<Savedpage> {
  Color? chatBox = Colors.blue[900];
  Color? chatText = Colors.white;
  Color? ImgBox = Colors.transparent;
  Color? ImgText = Colors.grey;
  Color? codeBox = Colors.transparent;
  Color? codeText = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(PageAnimationTransition(
                page: Bottomnav(),
                pageAnimationType: FadeAnimationTransition()));
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Text(
            'Saved',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CircleAvatar(
              radius: 20,
              child: Image.asset('assets/robo1.png'),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      chatBox = Colors.blue[900];
                      chatText = Colors.white;
                      ImgBox = Colors.transparent;
                      ImgText = Colors.grey;
                      codeBox = Colors.transparent;
                      codeText = Colors.grey;
                    });
                  },
                  child: Container(
                    width: 55,
                    height: 40,
                    decoration: BoxDecoration(
                        color: chatBox,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        'Chat',
                        style: TextStyle(color: chatText),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    chatBox = Colors.transparent;
                    chatText = Colors.grey;
                    ImgBox = Colors.blue[900];
                    ImgText = Colors.white;
                    codeBox = Colors.transparent;
                    codeText = Colors.grey;
                  });
                },
                child: Container(
                  width: 55,
                  height: 40,
                  decoration: BoxDecoration(
                      color: ImgBox,
                      // color: Colors.blue[900],
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      'Image',
                      style: TextStyle(color: ImgText),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    chatBox = Colors.transparent;
                    chatText = Colors.grey;
                    ImgBox = Colors.transparent;
                    ImgText = Colors.grey;
                    codeBox = Colors.blue[900];
                    codeText = Colors.white;
                  });
                },
                child: Container(
                  width: 55,
                  height: 40,
                  decoration: BoxDecoration(
                      color: codeBox,
                      //  color: Colors.blue[900],
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      'Code',
                      style: TextStyle(color: codeText),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 110),
              //   child: IconButton(
              //     onPressed: () => null,
              //     icon: Icon(Icons.search_rounded),
              //   ),
              // )
            ],
          )
        ],
      ),
    );
  }
}
