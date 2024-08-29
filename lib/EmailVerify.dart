import 'package:flutter/material.dart';

class Emailverify extends StatefulWidget {
  const Emailverify({super.key});

  @override
  State<Emailverify> createState() => _EmailverifyState();
}

class _EmailverifyState extends State<Emailverify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Image.asset(
                    'assets/robo1.png',
                    height: 250,
                    width: 250,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 140),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/email.png'),
                            fit: BoxFit.cover)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'We have sent you an email',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 47, 143, 221)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Click on the email verification link sent to \n           you on UserInfo@gmail.com.\n                   Then click on confirm',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 47, 143, 221)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 40),
              child: Row(
                children: [
                  Text(
                    "Didn't receive the email yet?",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 47, 143, 221)),
                  ),
                  TextButton(
                    onPressed: () => null,
                    child: Text(
                      'Send Again',
                      style: TextStyle(
                          decorationColor:
                              const Color.fromARGB(255, 47, 143, 221),
                          color: const Color.fromARGB(255, 47, 143, 221),
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 80, left: 70, right: 70),
              child: MaterialButton(
                height: 50,
                elevation: 3,
                color: Colors.white,
                shape: StadiumBorder(),
                onPressed: () => null,
                child: Center(
                  child: Text(
                    'Open Email App',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 47, 143, 221),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TextButton(
                onPressed: () => null,
                child: Text(
                  'Next',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 47, 143, 221),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
