import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;

import 'Clases.dart';

class MyARPGs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyXmlReaderARPGs(),
    );
  }
}

class MyXmlReaderARPGs extends StatefulWidget {
  @override
  _MyXmlReaderARPGsState createState() => _MyXmlReaderARPGsState();
}

class _MyXmlReaderARPGsState extends State<MyXmlReaderARPGs> {
  List<ARPG> arpgList = [];

  @override
  void initState() {
    super.initState();
    _leerARPGs();
  }

  Future<void> _leerARPGs() async {
    final data = await DefaultAssetBundle.of(context).loadString('documentos/arpg.xml');
    final document = xml.XmlDocument.parse(data);
    final elementos = document.findAllElements('categoria');

    setState(() {
      arpgList = elementos.map((elemento) {
        final titulo = elemento.findElements('titulo').first.text;
        final imagen = elemento.findElements('imagen').first.text;
        final descripcion = elemento.findElements('descripcion').single.text;
        return ARPG(titulo: titulo, imagen: imagen, descripcion: descripcion);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(143, 32, 115, 1),
        title: Text("ViChat - ARPGs"),
      ),
      body: ListView.builder(
        itemCount: arpgList.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text(
                  arpgList[index].titulo,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Título: ${arpgList[index].titulo}'),
                    Image.network(
                      arpgList[index].imagen,
                      width: 400,
                      height: 400,
                    ),
                    Text('Descripción: ${arpgList[index].descripcion}'),
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
