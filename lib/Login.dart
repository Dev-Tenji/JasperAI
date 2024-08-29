import 'package:flutter/material.dart';
import 'package:jasper_ai/SignUp.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                          'Sign In',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(' to access your\n account'),
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
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 15),
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Email or username',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            //   child: Container(
            //     width: 270,
            //     height: 50,
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: TextFormField(
            //       decoration: InputDecoration(
            //         contentPadding: EdgeInsets.only(top: 15),
            //         prefixIcon: Icon(Icons.email),
            //         hintText: 'Email',
            //         border: InputBorder.none,
            //       ),
            //     ),
            //   ),
            // ),
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
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 15),
                    suffixIcon: IconButton(
                        onPressed: () => null,
                        icon: Icon(Icons.remove_red_eye)),
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
                onPressed: () => null,
                child: Text(
                  'Login    ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 135, bottom: 20),
              child: Text(
                'Or Sign in With',
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
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(PageAnimationTransition(
                          page: Signup(),
                          pageAnimationType: FadeAnimationTransition()));
                    },
                    child: Text(
                      "don't have an account? Sign up",
                      style: TextStyle(color: Colors.blue, fontSize: 10),
                    ),
                  ),
                  TextButton(
                    onPressed: () => null,
                    child: Text('Forgot password?',
                        style: TextStyle(color: Colors.blue, fontSize: 10)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
