import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:web_scraper/web_scraper.dart';

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
      home: Scaffold(
        appBar: AppBar(
          title: Text('Defunciones Tomelloso'),
          centerTitle: true,
        ),
        body: Center(
          child: FutureBuilder<Widget>(
            future: obtenerImagenes(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!;
              } else if (snapshot.hasError) {
                print("${snapshot.error}");
                return Text("Hay un problema");
              }

              // Por defecto, muestra un loading spinner
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  Future<Widget> obtenerImagenes()async {

      final WebScraper webScraper = WebScraper('https://lavozdetomelloso.com');
      List<Map<String, dynamic>> elements = [];
      //:5500
      if (await webScraper.loadWebPage('/Servicio/2/funerales')) {
        elements= webScraper.getElement('p > img', ['src']);
      }
      if(elements.length==0){
        return Text("Hoy no se ha muerto nadie, gracias a Dios", style: TextStyle(fontSize: 40),);
      }

      return ListView.builder(
          itemCount: elements.length,
          itemBuilder: (c,index) {
            return Column(
              children: [
                InteractiveViewer(child: Html(data: "<img src=\"${elements[index]["attributes"]["src"]}\"/>",)),
                Divider(color: Colors.black,height: 20,),
              ],
            );
          }
      );
  }
}