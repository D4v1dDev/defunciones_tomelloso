
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Defunciones Tomelloso'),
          centerTitle: true,
        ),
      body: Center(
        child: IntrinsicHeight(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/defunciones');
                      },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Defunciones",style: TextStyle(fontSize: 35),),
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/gasolina');
                      },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Gasolina",style: TextStyle(fontSize: 35),),
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}