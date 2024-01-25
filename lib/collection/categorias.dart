import 'package:flutter/material.dart';
import '../pages/profile.dart';
import 'mobas.dart';
import 'arpg.dart';  // Importa la clase ARPG
import 'shooter.dart';  // Importa la clase Shooter

class Categorias extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text('ViChat'),

            actions: <Widget>[ 
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                      );
                  },
                  icon: CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://i.pinimg.com/originals/37/8a/27/378a270e775265622393da8c0527417e.jpg',
                      ),
                    ),
                  ),
              ],

            ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFBFC7D2),
                border: Border.all(
                  color: Colors.grey,
                  width: 2.0, 
                  ),           
                borderRadius: BorderRadius.circular(8.0), // Radio de borde para esquinas redondeadas
                ),
              padding: const EdgeInsets.all(16.0),
              child: Column (
                children: [
                Text(
                  'ViChat',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                SizedBox(height: 8), // Espacio entre el nombre de la aplicación y el mensaje de bienvenida
                Text(
                  '¡Bienvenido a ViChat! Elige tu categoría de juegos favorita y disfruta con amigos.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    ),
                  ),                ],
                ),

              ),
            SizedBox(height: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                Flexible(
                  child: _buildCard(
                    title: 'Mobas',
                    description: 'Aventurate en los mobas más populares con tus amigos',
                    image: 'assets/images/lol.png',
                    onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyMobas()),
                        );
                    },
                    ),
                  ),
                Flexible(
                  child: _buildCard(
                    title: 'ARPG',
                    description: 'Descubre emocionantes aventuras en juegos de rol de acción',
                    image: 'assets/images/diablo.png',
                    onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyARPGs()),
                        );
                    },
                    ),
                  ),
                Flexible(
                    child: _buildCard(
                      title: 'Shooter',
                      description: 'Enfrenta desafíos y demuestra tu puntería en juegos de disparos',
                      image: 'assets/images/valoo.jpg',
                      onTap: () {
                      try {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyShooters()),
                          );
                      } catch (e) {
                      print('Error al navegar: $e');
                      }
                      },
                      ),

                    ),
                ],
                ),
                ),
                ],
                ),
                );
    }
  Widget _buildCard({
      required String title,
      required String description,
      required String image,
      required VoidCallback onTap,
      }) {
    return GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
              Image.asset(
                image,
                fit: BoxFit.cover,
                height: 200,
                ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                SizedBox(height: 40),
                Text(
                  title,
                  style: TextStyle(fontSize: 50, color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                  ),

                  ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    description,
                    style: TextStyle(fontSize: 30, color: Colors.white),
                    textAlign: TextAlign.center,
                    ),
                  ),
                ],
                ),
              ],
              ),
              ),
              ),
              );
  }
}

