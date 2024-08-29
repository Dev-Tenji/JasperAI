import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:jasper_ai/Applogic.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:speech_to_text_google_dialog/speech_to_text_google_dialog.dart';
import 'package:stability_image_generation/stability_image_generation.dart';

class Imggen extends StatefulWidget {
  const Imggen({super.key});

  @override
  State<Imggen> createState() => _ImggenState();
}

class _ImggenState extends State<Imggen> {
  List<Widget> ImgDone = [];
  List<String> promp2 = [];
  String voiceText = '';
  final TextEditingController ImgText = TextEditingController();
  var authkey = GlobalKey<FormState>();
  // bool scale = true;
  // void Upscale() {
  //   setState(() {
  //     scale = !scale;
  //   });
  // }

  String apiKey = 'sk-klH7OjhNFK05y2yR9NPHkBlc9SZPSbFSdheOtCTc1biFoP2u';

  final StabilityAI _ai = StabilityAI();
  Future<Uint8List> _generate(String query) async {
    Uint8List image = await _ai.generateImage(
      apiKey: apiKey,
      imageAIStyle: ImageAIStyle.classicism,
      prompt: query,
    );
    return image;
  }

  Widget ImgGen(String prompt) {
    return FutureBuilder<dynamic>(
      // Call the generate() function to get the image data
      future: _generate(prompt),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the image data, display a loading indicator
          return LoadingAnimationWidget.staggeredDotsWave(
            color: Colors.blue,
            size: 30,
          );
        } else if (snapshot.hasError) {
          // If an error occurred while getting the image data, display an error
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 150),
                child: InstaImageViewer(
                    child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: MemoryImage(snapshot.data),
                          fit: BoxFit.fitWidth),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black),
                )),
              ),
              Positioned(
                left: 210,
                top: 5,
                child: Column(
                  children: [
                    MaterialButton(
                      shape: CircleBorder(),
                      onPressed: () {
                        Applogic.SaveImg(snapshot.data, context);
                      },
                      child: Icon(Icons.download),
                    ),
                    MaterialButton(
                      shape: CircleBorder(),
                      onPressed: () => null,
                      child: Icon(Icons.save),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else if (!snapshot.hasData) {
          // If no data is available, display a placeholder or an empty container
          return SizedBox.shrink();
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var tent = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text(
          'JasperAI',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
      body: Container(
        width: tent.width,
        height: tent.height,
        child: Container(
          color: Colors.transparent,
          height: tent.height,
          width: tent.width,
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                height: 600,
                child: ListView.builder(
                  itemCount: promp2.length,
                  itemBuilder: (context, index) {
                    final chat = promp2[index];
                    final img = ImgDone[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Center(
                            child: Text(
                              DateTime.now().toString(),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 136, 133, 132)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 170, bottom: 15),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 27, 76, 150),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              chat,
                              style: TextStyle(color: Colors.white),
                            ), //.substring(0, 10)
                          ),
                        ),
                        img,
                      ],
                    );
                  },
                ),
              ),
              Container(
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: GestureDetector(
                          child: Icon(Icons.star_border_rounded)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: GestureDetector(child: Icon(Icons.image_outlined)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 7),
                      child: GestureDetector(child: Icon(Icons.mic)),
                    ),
                    Form(
                      key: authkey,
                      child: Container(
                        width: 207,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(30)),
                        child: TextFormField(
                          minLines: null,
                          maxLines: null,
                          expands: true,
                          controller: ImgText,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 7, left: 12),
                              hintText: 'Ask me anything...',
                              hintStyle: TextStyle(),
                              border: InputBorder.none),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please type something';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (authkey.currentState!.validate()) {
                          promp2.add(ImgText.text);
                          Widget jake = ImgGen(ImgText.text);
                          ImgDone.add(jake);
                          setState(() {});
                          ImgText.clear();
                        }
                      },
                      icon: Icon(Icons.send_rounded),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
