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
  void initState() {
    carregarNomeUsuario();
    super.initState();
  }

  Future<void> salvarRegistro(String valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("nomeUsuario", valor);
  }

  void carregarNomeUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String nomeSalvo = prefs.getString("nomeUsuario") ?? "Desconhecido";
    setState(() {
      nomeUsuario = nomeSalvo;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              await salvarRegistro(nomeController.text);
              carregarNomeUsuario();
            },
            child: Text(("Salvar")),
          ),
          Text("Olá, seja bem vindo: $nomeUsuario"),
        ],
      ),
    );
  }
}
