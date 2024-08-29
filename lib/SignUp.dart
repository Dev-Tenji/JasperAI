import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jasper_ai/Applogic.dart';
import 'package:jasper_ai/HomeScreen.dart';
import 'package:jasper_ai/Login.dart';
import 'package:jasper_ai/usermodels.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:url_launcher/url_launcher.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
 
  final username = TextEditingController();
  final password = TextEditingController();
  final email = TextEditingController();
  bool showpassword = true;
  void switchpassword() {
    setState(() {
      showpassword = !showpassword;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/BG.png'), fit: BoxFit.cover)),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 50,
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text('to create an      \n account'),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  Image.asset(
                    'assets/robo1.png',
                    width: 150,
                    height: 150,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 10), //right:52
              child: Container(
                width: 270,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: username,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 15),
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Username',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Container(
                width: 270,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 15),
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Email',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Container(
                width: 270,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: password,
                  obscureText: showpassword,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 15),
                    suffixIcon: IconButton(
                      onPressed: () {
                        switchpassword();
                      },
                      icon: showpassword
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                    ),
                    prefixIcon: Icon(Icons.password),
                    hintText: 'Password',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                height: 50,
                color: Colors.blue,
                onPressed: () async {
                  Applogic.SignUp(username.text, password.text, email.text);
                  Applogic.EmailVerify(email.text, context, username.text, password.text);
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white),
                ),
                // Text(
                //   'Sign Up',
                //   style: TextStyle(color: Colors.white),
                // ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 135, bottom: 20),
              child: Text(
                'Or Sign up With',
                style: TextStyle(fontSize: 13),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Container(
                width: 270,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  onTap: () {
                    
                    Applogic.GoogleSign(context);
                  },
                  leading: Image.asset(
                    'assets/goog2.png',
                    width: 30,
                    height: 30,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 70),
                    child: Text('Google'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Container(
                width: 270,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  leading: Image.asset(
                    'assets/face2.png',
                    width: 30,
                    height: 30,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 70),
                    child: Text('Facebook'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Container(
                width: 270,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  leading: Image.asset(
                    'assets/MS.png',
                    width: 30,
                    height: 30,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 70),
                    child: Text('Microsoft'),
                  ),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(PageAnimationTransition(
                      page: LoginPage(),
                      pageAnimationType: FadeAnimationTransition()));
                },
                child: Text(
                  "already have an account? Login",
                  style: TextStyle(color: Colors.blue, fontSize: 10),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
