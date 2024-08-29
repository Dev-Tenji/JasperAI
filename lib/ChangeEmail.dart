import 'package:flutter/material.dart';

class Changeemail extends StatefulWidget {
  const Changeemail({super.key});

  @override
  State<Changeemail> createState() => _ChangeemailState();
}

class _ChangeemailState extends State<Changeemail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Back',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        title: Text(
          'Change Email',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Form(
            child: Container(
              width: double.infinity,
              height: 50,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'add your new email here...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 2, left: 10),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 500, left: 20, right: 20), //290
            child: MaterialButton(
              height: 50,
              shape: StadiumBorder(),
              color: Colors.blue,
              onPressed: () => null,
              child: Center(
                child: Text(
                  'Send',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}