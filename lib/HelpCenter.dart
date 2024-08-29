import 'package:flutter/material.dart';


class Helpcenter extends StatefulWidget {
  const Helpcenter({super.key});

  @override
  State<Helpcenter> createState() => _HelpcenterState();
}

class _HelpcenterState extends State<Helpcenter> {



  double ht = 500;
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
          'Help Center',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Form(
            child: Container(
              width: double.infinity,
              height: 50,
              child: TextFormField(

                decoration: InputDecoration(
                  hintText: 'Need any help message us here...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 2, left: 10),
                ),
              ),
            ),
          ),
          SizedBox(
            height: ht,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20), //290 ,top 500
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
          ),
        ],
      ),
    );
  }
}
