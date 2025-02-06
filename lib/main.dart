import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Для использования File

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sand Drawing',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 94, 83, 112)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Sand Drawing'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _counter = '';
  bool _isPressed = false;
  XFile? _imageFile; // Используем nullable тип

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile;
        });
      }
    } catch (e) {
      print("Ошибка при выборе изображения: $e");
    }
  }

  void _toggleButton() {
    setState(() {
      _isPressed = !_isPressed;
      _counter = _isPressed ? 'Test' : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _counter,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            if (_imageFile != null)
              Image.file(
                File(_imageFile!.path), // Используем "!" для доступа к path
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Загрузить картинку'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleButton,
        backgroundColor: _isPressed ? Colors.green : Colors.blue,
        child: Icon(
          _isPressed ? Icons.check : Icons.add,
        ),
      ),
    );
  }
}
