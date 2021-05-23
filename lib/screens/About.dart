import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Contact'),
              Text("dannyfachrul@gmail.com",style: TextStyle(fontSize: 25),)
            ],
          ),
        ),
      ),
    );
  }
}
