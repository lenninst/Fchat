import 'package:flutter/material.dart';

class EditarPerfil extends StatefulWidget {
  @override
  _EditarPerfilState createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();

  @override
  void initState() {
    nombreController.text = 'JaimitoElPro';
    descripcionController.text = 'Jugador experto mi pasión es no tener amigos en la vida real. 🥲👍';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: nombreController,
              decoration: InputDecoration(labelText: 'Nombre de usuario'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: descripcionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            SizedBox(height: 16.0),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, { 
                  'nombre': nombreController.text,
                  'descripcion': descripcionController.text,
                });
              },
              child: Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}

