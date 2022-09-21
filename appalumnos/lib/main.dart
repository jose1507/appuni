import 'package:flutter/material.dart';

import 'auth/auth.dart';


void main() {
  runApp(Aplication());
}

class Aplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UTP',
      home:login(),
      theme: ThemeData(
          primaryColor: Color.fromARGB(255, 0, 132, 255), accentColor: Color.fromARGB(255, 44, 14, 218)),
    );
  }
}
