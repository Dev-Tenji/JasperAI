import 'dart:ffi';
import 'dart:core';
import 'dart:io';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jasper_ai/bottomNav.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:speech_to_text_google_dialog/speech_to_text_google_dialog.dart';

class Chatpage extends StatefulWidget {
  const Chatpage({super.key});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  String voiceText = '';
  bool scale = false;
  void Upscale() {
    setState(() {
      scale = !scale;
    });
  }

  void OnImageSend() async {
    ImagePicker picker = ImagePicker();
    XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      ChatMessage chatMessage = ChatMessage(
          user: chatUser,
          createdAt: DateTime.now(),
          text: 'please describe the image',
          medias: [
            ChatMedia(url: xFile.path, fileName: '', type: MediaType.image)
          ]);
      OnSend(chatMessage);
    }
  }

  List<ChatMessage> messages = [];
  ChatUser chatUser = ChatUser(id: '0', firstName: 'Andy');
  ChatUser Jasper = ChatUser(id: '1', firstName: 'Gemini');
  Widget ChatUI() {
    return DashChat(
      currentUser: chatUser,
      onSend: OnSend,
      messages: messages,
      inputOptions: InputOptions(leading: [
        IconButton(
          onPressed: () => null,
          icon: Icon(Icons.star_border_rounded),
        ),
        IconButton(
          onPressed: () => OnImageSend(),
          icon: Icon(Icons.image_outlined),
        ),
        IconButton(
          onPressed: () async {
            await SpeechToTextGoogleDialog.getInstance().showGoogleDialog(
                onTextReceived: (data) {
              setState(() {
                voiceText = data.toString();
              });
            });
          },
          icon: Icon(Icons.mic),
        )
      ]),
    );
  }

  Gemini gemini = Gemini.instance;

  void OnSend(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      String question = chatMessage.text;
      List<Uint8List>? images;
      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [
          File(chatMessage.medias!.first.url).readAsBytesSync(),
        ];
      }
      // print(images!.isEmpty);
      gemini.streamGenerateContent(question, images: images).listen((events) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == Jasper) {
          lastMessage = messages.removeAt(0);
          String response = events.content?.parts?.fold(
                "",
                (previous, current) => "$previous ${current.text}",
              ) ??
              "";
          lastMessage.text += response;
          setState(() {
            messages = [lastMessage!, ...messages];
          });
        } else {
          String response = events.content?.parts?.fold(
                "",
                (previous, current) => "$previous ${current.text}",
              ) ??
              "";
          ChatMessage message = ChatMessage(
              user: Jasper, createdAt: DateTime.now(), text: response);
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        surfaceTintColor: Colors.white,

        // title: Image.asset(
        //   'assets/gem.png',
        //   width: 100,
        //   height: 100,
        // ),
        title: Text(
          'JasperAI',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            // Navigator.pop(context);
            Navigator.of(context).push(PageAnimationTransition(
                page: Bottomnav(),
                pageAnimationType: FadeAnimationTransition()));
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CircleAvatar(
              radius: 20,
              child: Image.asset('assets/robo1.png'),
            ),
          ),
          // Icon(Icons.multitrack_audio_outlined),
          // SizedBox(
          //   width: 10,
          // ),
          // Icon(Icons.double_arrow_rounded)
        ],
      ),
      // body: Stack(
      //   children: [
      //     ListView(
      //       children: [
      //         Center(
      //           child: Column(
      //             children: [
      //               Text(
      //                 'Hello, Ask Me \n Anything...',
      //                 style:
      //                     TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(right: 30),
      //                 child: Text(
      //                   'Last Update: 21.06.2024',
      //                   style: TextStyle(fontSize: 12),
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(right: 40, top: 40),
      //                 child: Container(
      //                   height: 50,
      //                   width: 50,
      //                   decoration: BoxDecoration(
      //                       borderRadius: BorderRadius.circular(50),
      //                       color: Colors.purple[200]),
      //                   child: Icon(
      //                     Icons.light_mode,
      //                     color: Colors.white,
      //                   ),
      //                 ),
      //               ),
      //               Padding(
      //                 padding:
      //                     const EdgeInsets.only(right: 20, top: 5, left: 10),
      //                 child: Card(
      //                   elevation: 5,
      //                   shape: RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(20)),
      //                   child: Container(
      //                     height: 45,
      //                     width: 415,
      //                     decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.circular(20)),
      //                     child: Padding(
      //                       padding: const EdgeInsets.only(
      //                         left: 10,
      //                       ),
      //                       child: Row(
      //                         children: [
      //                           Icon(
      //                             Icons.circle,
      //                             color: Colors.purple[200],
      //                             size: 10,
      //                           ),
      //                           SizedBox(
      //                             width: 5,
      //                           ),
      //                           Text(
      //                               'Explain quantum computing in simple terms')
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               Padding(
      //                 padding:
      //                     const EdgeInsets.only(right: 10, top: 5, left: 10),
      //                 child: Card(
      //                   elevation: 5,
      //                   shape: RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(20)),
      //                   child: Container(
      //                     height: 45,
      //                     width: 420,
      //                     decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.circular(20)),
      //                     child: Padding(
      //                       padding: const EdgeInsets.only(
      //                         left: 10,
      //                       ),
      //                       child: Row(
      //                         children: [
      //                           Icon(
      //                             Icons.circle,
      //                             color: Colors.purple[200],
      //                             size: 10,
      //                           ),
      //                           SizedBox(
      //                             width: 5,
      //                           ),
      //                           Text(
      //                               '"How do i make a HTTP request in Javascript?"'),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(right: 40, top: 30),
      //                 child: Container(
      //                   height: 50,
      //                   width: 50,
      //                   decoration: BoxDecoration(
      //                       borderRadius: BorderRadius.circular(50),
      //                       color: Colors.green[200]),
      //                   child: Icon(
      //                     Icons.cloud,
      //                     color: Colors.white,
      //                   ),
      //                 ),
      //               ),
      //               Padding(
      //                 padding:
      //                     const EdgeInsets.only(right: 40, top: 5, left: 30),
      //                 child: Card(
      //                   elevation: 5,
      //                   shape: RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(20)),
      //                   child: Container(
      //                     height: 45,
      //                     width: 415,
      //                     decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.circular(20)),
      //                     child: Padding(
      //                       padding: const EdgeInsets.only(
      //                         left: 10,
      //                       ),
      //                       child: Row(
      //                         children: [
      //                           Icon(
      //                             Icons.circle,
      //                             color: Colors.green[200],
      //                             size: 10,
      //                           ),
      //                           SizedBox(
      //                             width: 5,
      //                           ),
      //                           Text('Remember what the user said earlier')
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               Padding(
      //                 padding:
      //                     const EdgeInsets.only(right: 20, top: 5, left: 10),
      //                 child: Card(
      //                   elevation: 5,
      //                   shape: RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(20)),
      //                   child: Container(
      //                     height: 45,
      //                     width: 415,
      //                     decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.circular(20)),
      //                     child: Padding(
      //                       padding: const EdgeInsets.only(
      //                         left: 10,
      //                       ),
      //                       child: Row(
      //                         children: [
      //                           Icon(
      //                             Icons.circle,
      //                             color: Colors.green[200],
      //                             size: 10,
      //                           ),
      //                           SizedBox(
      //                             width: 5,
      //                           ),
      //                           Text(
      //                               'Allows user to provide follow-up corrections')
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(right: 40, top: 30),
      //                 child: Container(
      //                   height: 50,
      //                   width: 50,
      //                   decoration: BoxDecoration(
      //                       borderRadius: BorderRadius.circular(50),
      //                       color: Colors.yellow[700]),
      //                   child: Icon(
      //                     Icons.flash_on_rounded,
      //                     color: Colors.white,
      //                   ),
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(right: 5, top: 5, left: 7),
      //                 child: Card(
      //                   elevation: 5,
      //                   shape: RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(20)),
      //                   child: Container(
      //                     height: 45,
      //                     width: 415,
      //                     decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.circular(20)),
      //                     child: Padding(
      //                       padding: const EdgeInsets.only(
      //                         left: 10,
      //                       ),
      //                       child: Row(
      //                         children: [
      //                           Icon(
      //                             Icons.circle,
      //                             color: Colors.yellow[700],
      //                             size: 10,
      //                           ),
      //                           SizedBox(
      //                             width: 5,
      //                           ),
      //                           Text(
      //                               'May occasionally generate incorrect responses')
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(
      //                     right: 50, top: 5, left: 20, bottom: 80),
      //                 child: Card(
      //                   elevation: 5,
      //                   shape: RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(20)),
      //                   child: Container(
      //                     height: 45,
      //                     width: 415,
      //                     decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.circular(20)),
      //                     child: Padding(
      //                       padding: const EdgeInsets.only(
      //                         left: 10,
      //                       ),
      //                       child: Row(
      //                         children: [
      //                           Icon(
      //                             Icons.circle,
      //                             color: Colors.yellow[700],
      //                             size: 10,
      //                           ),
      //                           SizedBox(
      //                             width: 5,
      //                           ),
      //                           Text('Uses Google Gemni under the Hood')
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         )
      //       ],
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(top: 604),
      //       child: Container(
      //         height: 60,
      //         width: double.infinity,
      //         color: Colors.white,
      //         child: Row(
      //           children: [
      //             Padding(
      //               padding: const EdgeInsets.only(left: 5),
      //               child:
      //                   GestureDetector(child: Icon(Icons.star_border_rounded)),
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.only(left: 10),
      //               child: GestureDetector(child: Icon(Icons.image_outlined)),
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.only(left: 10, right: 7),
      //               child: GestureDetector(child: Icon(Icons.mic)),
      //             ),
      //             Form(
      //               child: Container(
      //                 width: 207,
      //                 height: 50,
      //                 decoration: BoxDecoration(
      //                     color: Colors.grey[100],
      //                     borderRadius: BorderRadius.circular(30)),
      //                 child: TextFormField(
      //                   decoration: InputDecoration(
      //                       contentPadding: EdgeInsets.only(top: 2, left: 10),
      //                       hintText: 'Ask me anything...',
      //                       border: InputBorder.none),
      //                 ),
      //               ),
      //             ),
      //             IconButton(
      //               onPressed: () => null,
      //               icon: Icon(Icons.send_rounded),
      //             )
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      body: GestureDetector(child: ChatUI()),
    );
  }
}
