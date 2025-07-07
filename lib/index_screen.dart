import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  List<File> imagenes = [];

  Future<void> cargarImagenes() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
      withData: false,
    );

    if (result != null) {
      setState(() {
        imagenes.addAll(result.paths.map((path) => File(path!)));
      });
    } else {
      debugPrint("Usuario canceló selección.");
    }
  }



  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final nombreCompleto = args?['nombreCompleto'] ?? 'Usuario';

    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido, $nombreCompleto'),
      ),
      body: Column(
        children: [
          ElevatedButton.icon(
            onPressed: cargarImagenes,
            icon: const Icon(Icons.add_photo_alternate),
            label: const Text('Cargar imágenes'),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: imagenes.isEmpty
                ? const Center(child: Text('No hay imágenes cargadas.'))
                : GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: imagenes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return Image.file(
                  imagenes[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
