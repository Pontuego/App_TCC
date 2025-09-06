import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String name;

  const HomeScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tela Inicial")),
      body: Center(
        child: Text(
          "Bem vindo $name. Sua aula será na sala 255 com o prof. Mário hoje. "
          "Você terá aula de x materia. Você tem 50 minutos para chegar na sala, "
          "sua aula começará as 19:10.",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
