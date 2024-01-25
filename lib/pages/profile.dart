import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'editarPerfil.dart';
import 'usuario.dart';

// Definir las clases Usuarios y Games según tus necesidades

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Perfil',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('My perfil'),
        ),
        body: ProfileBoby(),
      ),
    );
  }
}

class ProfileBoby extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            color: Colors.grey[000],
            height: 200.0,
            padding: EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _fotoPerfil(
                    'https://i.pinimg.com/originals/37/8a/27/378a270e775265622393da8c0527417e.jpg'),
                SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _seccionDatos(context),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Usuarios>>(
              future: _mostrarUsuarios(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                  return ListView(
                      children: snapshot.data?.map((usuario) {
                        return Column(
                            children: <Widget>[
                            ListTile(
                              title: Text(usuario.nombre_usuario, style: TextStyle(fontSize: 20.0),),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Text('Edad: ${usuario.edad}'),
                                Text('Juegos: ${usuario.juegos}'),
                                Text('Rango: ${usuario.rango}'),
                                Text('País: ${usuario.pais}'),
                                ],
                                ),
                              leading:CircleAvatar( 
                                backgroundImage: NetworkImage('https://avatar.iran.liara.run/public'),
                              ) ,
                              trailing: Icon(Icons.sms),
                              onTap: () => print('Click en usuario'),
                              ),
                            Divider(),
                            ],
                            );
                      }).toList()?.cast<Widget>() ?? [],
                    ); 
                  }
              },
              ),
              ),   
          ]
          ),
    );
  }

  List<Widget> _seccionDatos(BuildContext context){
    return [
      const Text(
        'JaimitoElPro ',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
          color: Colors.black,
        ),
      ),
      const Text(
        'Jugador experto mi pasion es no tener amigos enla vida real. 🥲👍',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
      ),
      SizedBox(height: 10.0),

      ElevatedButton(
        onPressed: (){
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => EditarPerfil()),
            );
            },

        child: Text('Editar'),
        ),
    ];
  }

  Widget _fotoPerfil(String imageUrl) {
    return CircleAvatar(
        radius: 50.0, backgroundImage: NetworkImage(imageUrl));
  }
}

Future<List<Usuarios>> _mostrarUsuarios() async {
  final response = await http.get(
      Uri.parse('https://raw.githubusercontent.com/lenninst/usuarioDemoJson/main/demo_friends%20.json'));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);

    List<Usuarios> usuarios = [];
    for (var userData in data) {
      final String nombreUsuario = userData['nombre_usuario'];
      final String edad = userData['edad'].toString();
      final List<String> juegos = List<String>.from(userData['juegos']); // Convertir la propiedad 'juegos' a una lista de cadenas
      final String rango = userData['rango'];
      final String pais = userData['pais'];

      usuarios.add(Usuarios(
        nombre_usuario: nombreUsuario,
        edad: edad,
        juegos: juegos,
        rango: rango,
        pais: pais,
      ));
    }

    return usuarios;
  } else {
    throw Exception('Error al cargar lista de usuarios');
  }
}

