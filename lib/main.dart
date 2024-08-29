import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:jasper_ai/ChatPage.dart';
import 'package:jasper_ai/EmailVerify.dart';
import 'package:jasper_ai/FeedBack.dart';
import 'package:jasper_ai/HelpCenter.dart';
import 'package:jasper_ai/HomeScreen.dart';
import 'package:jasper_ai/ImgGen.dart';
import 'package:jasper_ai/LoaderScreen.dart';
import 'package:jasper_ai/RateUs.dart';
import 'package:jasper_ai/SavedPage.dart';
import 'package:jasper_ai/Setting.dart';
import 'package:jasper_ai/SignUp.dart';
import 'package:jasper_ai/StartChat.dart';
import 'package:jasper_ai/VoiceChat.dart';
import 'package:jasper_ai/bottomNav.dart';
import 'package:jasper_ai/usermodels.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void main() {
  Gemini.init(apiKey: 'AIzaSyBUdf1JePsDFExE4xZhtVS0TzlKxlfGwbw');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => Bottomnav(),
        },
      ),
      overlayColor: Colors.transparent,
      duration: Durations.medium4,
      useDefaultLoading: false,
      overlayWidgetBuilder: (_) {
        
        return Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: Colors.blue,
            size: 30,
          ),
        );
      },
      closeOnBackButton: true,
    );
  }
}
