import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData.dark(), home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nomeController = TextEditingController();
  String nomeUsuario = "";

  @override
  Widget build(BuildContext context) {
    void salvarRegistro(String valor) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("nomeUsuario", valor);
    }

    mostrarNome() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString("nomeUsuario") ?? "";
    }

    return Scaffold(
      appBar: AppBar(title: Text("Nome de usuário")),
      body: Column(
        children: [
          TextField(
            controller: nomeController,
            decoration: InputDecoration(label: Text("Nome de usuário")),
          ),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                salvarRegistro(nomeController.text);
              });
            },
            child: Text(("Salvar")),
          ),
          ElevatedButton(
            onPressed: () async {
              setState(() async {
                nomeUsuario = await mostrarNome();
              });
            },
            child: Text(("Mostrar")),
          ),
          Text("Olá, seja bem vindo: $nomeUsuario"),
        ],
      ),
    );
  }
}
