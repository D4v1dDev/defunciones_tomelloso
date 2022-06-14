import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';

class Gasolina extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Gasolina"),centerTitle: true,),
        body : Center(
          child: FutureBuilder<Widget>(
            future: obtenerPrecios(),
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
        )
    );
  }

  // Devuelve {"Gasolina" : {"Gasolinera 1" : 1.903}, "Gasoleo" : {"Gasolinera 1" : 1.892}}
  Future<Widget> obtenerPrecios () async {
    final WebScraper pagina1 = WebScraper('https://entomelloso.com');

    List<String> precios = [];
    int indice = 0;
    String nombreUltimoElementoValido = "";
    if (await pagina1.loadWebPage('/precios-combustibles-en-tomelloso/')) {
      List elementos = pagina1.getElement('tbody > tr > td', ['title']);
      elementos.forEach((element) {
        if(element["title"].toString().trim().isNotEmpty){
          if(indice % 4 == 0){
            precios.add(element["title"].toString().trim());
          }else if (indice % 4 == 1){
            precios[(indice/4).floor()] += "\t"+element["title"].toString().trim();
          }
          indice++;
        }
      });
    }

    if(precios.length == 0) return Text("Problema al obtener los datos");

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),

            elevation: 5,
            child: IntrinsicHeight(
                child: Column(children: List.generate(5, (index) => index == 0? Text("Gasolina 95", style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),):index==1?Divider(thickness: 5,):Text(precios[index-2],style: TextStyle(fontSize: 27,))))
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 5,
            child: IntrinsicHeight(
                child: Column(children: List.generate(5, (index) => index == 0? Text("Gasóleo A", style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),):index==1?Divider(thickness: 5,):Text(precios[index+15],style: TextStyle(fontSize: 27,),)))
            ),
          ),
        ),
      ],
    );
  }
}