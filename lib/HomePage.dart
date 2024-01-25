import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:http/http.dart' as http;
import 'Games.dart';
import 'pages/profile.dart';

class HomePage extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      return MaterialApp(
          title: 'Iniciar Session',
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Juegos'),
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
                      'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png',
                      ),
                    ),
                  ),
              ],
              ),
            body: MyBody(), 
            ),
          );
    }
}

class MyBody extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      return Center(
          child: FutureBuilder<List<Games>>(
            future: _getGames(),
            builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(),
                );
            } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}'),
                );
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(
                child: Text('No se encontraron juegos'),
                );
            } else {
            final games = snapshot.data!;
            return ListView.builder(
                itemCount: games.length,
                itemBuilder: (context, index) {
                final game = games[index];
                return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Colors.blueGrey.shade100,
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[ 
                      Image.network(
                        game.thumbnail,
                        width: double.infinity,
                        height: 160,
                        fit: BoxFit.cover,
                        ),
                      Text(
                        game.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.grey[800],
                          ),
                        ),
                      SizedBox(height: 10),
                      Text(
                        game.short_description,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                          ),
                        ),
                      SizedBox(height: 20),
                      Text('Detalles', 
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.grey[800],
                            ),
                          ),
                      SizedBox(height: 10),
                      Text( 
                          'Url: ${game.game_url}',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue[700],
                            ),
                          ),
                      SizedBox(height: 10),
                      Text( 'Tipo: ${game.genre}',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            ),
                          ),
                      SizedBox(height: 10),
                      Text( 'Plataforma: ${game.platform}',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            ),
                          ),
                      SizedBox(height: 10),
                      Text( 'Desarrollador: ${game.developer}',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            ),
                          ),
                      Row(
                          children: <Widget>[
                          Spacer(),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.transparent,
                              ),
                            child: Text(
                              "Guardar",
                              style: TextStyle(color: Colors.blueAccent),
                              ),
                            onPressed: () {},
                            ),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.transparent,
                              ),
                            child: Text(
                              "Explorar",
                              style: TextStyle(color: Colors.blueAccent),
                              ),
                            onPressed: () {},
                            ),
                          ],
                          ),
                          ],
                          ),
                          );
                },
                );
            }
            },
            ),
            );
    }

  Future<List<Games>> _getGames() async {
    final response = await http.get(Uri.parse('https://raw.githubusercontent.com/lenninst/GamesJson/main/games.json'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      List<Games> games = [];
      for (var gamesInfo in data) {
        final String title = gamesInfo['title'];
        final String thumbnail = gamesInfo['thumbnail'];
        final String short_description = gamesInfo['short_description'];
        final String game_url = gamesInfo['game_url'];
        final String genre = gamesInfo['genre'];
        final String platform = gamesInfo['platform'];
        final String developer = gamesInfo['developer'];

        games.add(Games(
              title: title,
              thumbnail: thumbnail,
              short_description: short_description,
              game_url: game_url,
              genre: genre,
              platform: platform,
              developer: developer,
              ));
      }

      return games;
    } else {
      throw Exception('Error al cargar lista de juegos');
    }
  }

}






