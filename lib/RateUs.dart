import 'package:flutter/material.dart';

class RateUs extends StatefulWidget {
  const RateUs({super.key});

  @override
  State<RateUs> createState() => _RateUsState();
}

class _RateUsState extends State<RateUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: TextButton(
          onPressed: () => null,
          child: Text(
            'Back',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        title: Text(
          'Rate Us',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Form(
            child: Column(
              children: [
                // Row(
                //   children: [
                //     IconButton(
                //       onPressed: () => null,
                //       icon: Icon(Icons.star_border_outlined),
                //     ),
                //     IconButton(
                //       onPressed: () => null,
                //       icon: Icon(Icons.star_border_outlined),
                //     ),
                //     IconButton(
                //       onPressed: () => null,
                //       icon: Icon(Icons.star_border_outlined),
                //     ),
                //     IconButton(
                //       onPressed: () => null,
                //       icon: Icon(Icons.star_border_outlined),
                //     ),
                //     IconButton(
                //       onPressed: () => null,
                //       icon: Icon(Icons.star_border_outlined),
                //     ),
                //   ],
                // ),
                // Container(
                //   width: double.infinity,
                //   height: 50,
                //   child: TextFormField(
                //     keyboardType: TextInputType.number,
                //     decoration: InputDecoration(
                //       prefixIcon: Padding(
                //         padding: const EdgeInsets.only(bottom: 20),
                //         child: Icon(
                //           Icons.star,
                //           color: Colors.yellow,
                //         ),
                //       ),
                //       hintText: 'Give us your score e.g 5.0',
                //       border: InputBorder.none,
                //       contentPadding: EdgeInsets.only(top: 3, left: 5),
                //     ),
                //   ),
                // ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'tell us want seems to be wrong',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 2, left: 10),
                    ),
                  ),
                ),
              ],
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
