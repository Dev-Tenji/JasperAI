import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jasper_ai/usermodels.dart';

class Changedp extends StatefulWidget {
  const Changedp({super.key});

  @override
  State<Changedp> createState() => _ChangedpState();
}

class _ChangedpState extends State<Changedp> {
  bool CDP = false;
  ChangeDp() async {
    if (CDP == false) {
      return CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage('assets/robo1.png'),
      );
    } else {}
  }

  Widget ChangeDp2() {
    String Dp = '';
    void DD() async {
      ImagePicker picker = ImagePicker();
      XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
      if (xFile!.path.isNotEmpty) {
        setState(() async {
          await User.SetCDP(true);
          Dp = xFile.path;
        });
      } else {
        setState(() async {
          await User.SetCDP(false);
        });
      }
    }

    DD();
    return CircleAvatar(
      radius: 30,
      backgroundImage: AssetImage(Dp),
    );
  }

  void tty() async {
    await User.init();
    CDP = User.getCDP();
  }

  @override
  void initState() {
    tty();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GestureDetector(
        onTap: () {
          setState(() async {
            await User.SetCDP(true);
          });
        },
        child: CDP
            ? CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/robo1.png'),
              )
            : ChangeDp2(),
      ),
    );
  }
}
