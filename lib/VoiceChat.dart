import 'package:flutter/material.dart';
import 'package:gif/gif.dart';

class Voicechat extends StatefulWidget {
  const Voicechat({super.key});

  @override
  State<Voicechat> createState() => _VoicechatState();
}

class _VoicechatState extends State<Voicechat> with TickerProviderStateMixin {
  late final GifController gif;
  @override
  void initState() {
    gif = GifController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 80),
                child: Text(
                  'Hello, am Jasper\n how may i help you today?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 400),
                child: Center(
                  child: Gif(
                    width: 100,
                    height: 100,
                    autostart: Autostart.loop,
                    placeholder: (context) =>
                        const Center(child: CircularProgressIndicator()),
                    image: const AssetImage('assets/AI.gif'),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 700),
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: ListTile(
                leading: IconButton(
                  onPressed: () => null,
                  icon: Icon(Icons.close),
                ),
                trailing: IconButton(
                  onPressed: () => null,
                  icon: Icon(Icons.mic),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
