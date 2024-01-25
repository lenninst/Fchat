import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;

import 'Clases.dart';

class MyShooters extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      return MaterialApp(
          home: MyXmlReaderShooters(),
          );
    }
}

class MyXmlReaderShooters extends StatefulWidget {
  @override
    _MyXmlReaderShootersState createState() => _MyXmlReaderShootersState();
}

class _MyXmlReaderShootersState extends State<MyXmlReaderShooters> {
  List<Shooter> shooterList = [];

  @override
    void initState() {
      super.initState();
      _leerShooters();
    }

  Future<void> _leerShooters() async {
    final data = await DefaultAssetBundle.of(context).loadString('documentos/shooter.xml');
    final document = xml.XmlDocument.parse(data);
    final elementos = document.findAllElements('categoria');

    setState(() {
        shooterList = elementos.map((elemento) {
            final titulo = elemento.findElements('titulo').first.text;
            final imagen = elemento.findElements('imagen').first.text;
            final descripcion = elemento.findElements('descripcion').single.text;
            return Shooter(titulo: titulo, imagen: imagen, descripcion: descripcion);
            }).toList();
        });
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(143, 32, 115, 1),
            title: Text("ViChat - Shooters"),
            ),
          body: ListView.builder(
            itemCount: shooterList.length,
            itemBuilder: (context, index) {
            return Container(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    title: Text(
                      shooterList[index].titulo,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text('Título: ${shooterList[index].titulo}'),
                      Image.network(
                        shooterList[index].imagen,
                        width: 400,
                        height: 400,
                        ),
                      Text('Descripción: ${shooterList[index].descripcion}'),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
}
