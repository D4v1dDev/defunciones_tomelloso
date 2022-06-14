import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Defunciones extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text("Defunciones"),centerTitle: true,),
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
    );
  }

  Future<Widget> obtenerImagenes()async {

    List<Map<String, dynamic>> elements = [];
    /*final WebScraper pagina1 = WebScraper('https://lavozdetomelloso.com');

      List<Map<String, dynamic>> elements = [];

      if (await pagina1.loadWebPage('/Servicio/2/funerales')) {
        elements = pagina1.getElement('p > img', ['src']);
      }*/

    List<String> urlImagenes = [];

    elements.forEach((element) {urlImagenes.add(element["attributes"]["src"]);});

    for ( int i = 1; i < 10 ; i++){
      urlImagenes.add("https://entomelloso.com/e/00$i.png");
    }

    if(elements.length!=0){
      return Text("Hoy no se ha muerto nadie, gracias a Dios", style: TextStyle(fontSize: 40),);
    }

    return ListView.builder(
        itemCount: urlImagenes.length,
        itemBuilder: (c,index) {
          return Column(
            children: [
              InteractiveViewer(child: Image.network(urlImagenes[index]),),
              Divider(color: Colors.black,height: 20,),
            ],
          );
        }
    );
  }

}