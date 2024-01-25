import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;

import 'Clases.dart';

class MyMobas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyXmlReaderMobas(),
    );
  }
}

class MyXmlReaderMobas extends StatefulWidget {
  @override
  _MyXmlReaderMobasState createState() => _MyXmlReaderMobasState();
}

class _MyXmlReaderMobasState extends State<MyXmlReaderMobas> {
  List<Mobas> mobasList = [];

  @override
  void initState() {
    super.initState();
    _leerMobas();
  }

  Future<void> _leerMobas() async {
    final data = await DefaultAssetBundle.of(context).loadString('documentos/mobas.xml');
    final document = xml.XmlDocument.parse(data);
    final elementos = document.findAllElements('categoria');

    setState(() {
      mobasList = elementos.map((elemento) {
        final titulo = elemento.findElements('titulo').first.text;
        final imagen = elemento.findElements('imagen').first.text;
        final descripcion = elemento.findElements('descripcion').single.text;
        return Mobas(titulo: titulo, imagen: imagen, descripcion: descripcion);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(143, 32, 115, 1),
        title: Text("ViChat"),
      ),
      body: ListView.builder(
        itemCount: mobasList.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text(
                  mobasList[index].titulo,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Título: ${mobasList[index].titulo}'),
                    Image.network(
                      mobasList[index].imagen,
                      width: 400,
                      height: 400,
                    ),
                    Text('Descripción: ${mobasList[index].descripcion}'),
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
