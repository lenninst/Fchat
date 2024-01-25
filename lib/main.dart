import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';

import 'HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fchat',
      debugShowCheckedModeBanner: false,
        // useMaterial3 is deprecated, so it's better to remove it
      home: const MyHomePage(title: 'Inicio de sesión'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class SomeOtherPage extends StatelessWidget {
  const SomeOtherPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Your other page implementation goes here
    return Container();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  bool _verificarCredencial(){
    return emailController.text == '1' && passwordController.text == 'a';
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                  width: 100,
                  height: 50,
                  
                  margin: const EdgeInsets.only(bottom: 20.0),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 0, 0, 0),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Image.asset('assets/images/game.png'),
                ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Ingresa email',
                ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                top: 15.0,
                bottom: 15.0,
              ),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contraseña',
                  hintText: 'Ingresa una contraseña',
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Olvidaste la contraseña',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: () {
                  if (_verificarCredencial()){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=> HomePage()),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder:(BuildContext context) {
                        return AlertDialog ( 
                        title: const Text('Error de inicio de session'),
                        content: const Text('Email o contraseña incorrecta'),
                        actions: [
                          TextButton(
                          onPressed:() {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Ok'),
                          ),
                        ],
                        );
                      },
                      );
                  }
                },
                child: const Text(
                  'Ingresar',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(height: 130),
            const Text('Eres nuevo aquí? Crea una cuenta'),
          ],
        ),
      ),
    );
  }
}


