import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();

  void _irAIndex() {
    final nombre = _nombreController.text.trim();
    final apellido = _apellidoController.text.trim();

    if (nombre.isNotEmpty && apellido.isNotEmpty) {
      Navigator.pushNamed(
        context,
        '/index',
        arguments: {'nombreCompleto': '$nombre $apellido'},
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor ingrese ambos campos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _apellidoController,
              decoration: const InputDecoration(labelText: 'Apellido'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _irAIndex,
              child: const Text("Ingresar"),
            ),
          ],
        ),
      ),
    );
  }
}
