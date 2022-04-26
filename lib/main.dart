import 'package:flutter/material.dart';
import 'package:plaid_link/values/colors.dart';
import 'package:plaid_link/view/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Plaid App',
      theme: ThemeData(
        primarySwatch: Colours.blue,
        backgroundColor: Colours.background
      ),
      home: const HomePage(),
    );
  }
}

