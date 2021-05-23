import 'package:dicoding_submission_danny/screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:dicoding_submission_danny/screens/Listview.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/test': (context) => Example(),
    },
  ));
}

