import 'package:flutter/material.dart';
import 'package:jasper_ai/ChatPage.dart';
import 'package:jasper_ai/ImgGen.dart';
import 'package:jasper_ai/Nav.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool onType = true;
  void IsTyping(bool c) {
    setState(() {
      onType = c;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 177, 216, 248),
      drawer: NavBar(),
      resizeToAvoidBottomInset: false,
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 10),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/robo1.png'),
                ),
              ),
              Text(
                'Welcome to \n JasperAI',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Container(
                    width: 330,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      showCursor: !onType,
                      onTapOutside: (event) {
                        IsTyping(true);
                      },
                      onTap: () {
                        IsTyping(false);
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 18, left: 15),
                          hintText: 'Ask me anything....',
                          suffixIcon: onType
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        alignment: Alignment.centerLeft,
                                        onPressed: () => null,
                                        icon: Icon(Icons
                                            .photo_size_select_actual_outlined),
                                      ),
                                      IconButton(
                                        onPressed: () => null,
                                        icon: Icon(Icons.mic_none),
                                      ),
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding:
                                      const EdgeInsets.only(top: 6, right: 4),
                                  child: IconButton(
                                      onPressed: () => null,
                                      icon: Icon(Icons.send_sharp)),
                                ),
                          border: InputBorder.none),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                      PageAnimationTransition(
                                          page: Chatpage(),
                                          pageAnimationType:
                                              FadeAnimationTransition()));
                                },
                                child: Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Container(
                                    width: 150,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 7, top: 7, left: 5),
                                              child: CircleAvatar(
                                                radius: 23,
                                                backgroundColor: Colors.blue,
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 7),
                                              child: Text(
                                                'Content',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
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
                                Navigator.of(context).push(
                                    PageAnimationTransition(
                                        page: Imggen(),
                                        pageAnimationType:
                                            FadeAnimationTransition()));
                              },
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: Container(
                                  width: 150,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 7, top: 7, left: 5),
                                            child: CircleAvatar(
                                              radius: 23,
                                              backgroundColor: Colors.yellow,
                                              child: Icon(
                                                Icons.image_outlined,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 7),
                                            child: Text(
                                              'Image',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                    PageAnimationTransition(
                                        page: Chatpage(),
                                        pageAnimationType:
                                            FadeAnimationTransition()));
                              },
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: Container(
                                  width: 150,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 7, top: 7, left: 5),
                                            child: CircleAvatar(
                                              radius: 23,
                                              backgroundColor: Colors.green,
                                              child: Icon(
                                                Icons.code_rounded,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 7),
                                            child: Text(
                                              'Code',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 270),
                        child: Text(
                          'RECENT',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 240,
                        child: Center(
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                            ),
                            child: Center(
                              child: Text(
                                'no recent',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
