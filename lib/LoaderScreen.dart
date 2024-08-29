import 'package:flutter/material.dart';
import 'package:jasper_ai/Applogic.dart';

class Loaderscreen extends StatefulWidget {
  const Loaderscreen({super.key});

  @override
  State<Loaderscreen> createState() => _LoaderscreenState();
}

class _LoaderscreenState extends State<Loaderscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/robo1.png',
                  width: 100,
                  height: 100,
                ),
                Text(
                  'JasperAI',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue),
                )
              ],
            ),
          ),
          // Applogic.EmptyCont(context),
        ],
      ),
    );
  }
}
