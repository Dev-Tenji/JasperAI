import 'package:flutter/material.dart';

class Changepassword extends StatefulWidget {
  const Changepassword({super.key});

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
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
          'Change Password',
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
                  hintText: 'add your new password here...',
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