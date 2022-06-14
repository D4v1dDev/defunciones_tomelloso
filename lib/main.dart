import 'dart:async';

import 'package:defunciones_tomelloso/Defunciones.dart';
import 'package:flutter/material.dart';

import 'Gasolina.dart';
import 'Home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Defunciones',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        backgroundColor: Colors.white,
      ),
      routes: {
        '/' : (ctx) => Home(),
        '/defunciones' : (ctx) => Defunciones(),
        '/gasolina' : (ctx) => Gasolina(),
      },
    );
  }
}


