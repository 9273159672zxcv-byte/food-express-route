import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Фуд-Экспресс',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = false;
  String _resultText = 'Выберите Excel-файл для загрузки';

  Future<void> _pickAndUploadFile() async {
    try {
      // Выбор файла
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xls'],
      );

      if (result == null) return; // Пользователь отменил выбор

      setState(() {
        _isLoading = true;
        _resultText = 'Отправка файла на сервер...';
      });

      File file = File(result.files.single.path!);

      // ⚠️ ВАЖНО: Адрес сервера строго с http://
      var uri = Uri.parse('http://95.163.230.180:8081/upload');
      var request = http.MultipartRequest('POST', uri);
      
      // Добавляем файл в запрос
      request.files.add(await http.MultipartFile.fromPath('file', file.path));

      // Отправляем запрос
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      setState(() {
        _isLoading = false;
        if (response.statusCode == 200) {
          _resultText = 'Успех! Сервер ответил:\n${response.body}';
        } else {
          _resultText = 'Ошибка сервера: ${response.statusCode}\n${response.body}';
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _resultText = 'Ошибка сети: $e\nПроверьте, работает ли сервер и разрешен ли http в манифесте.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Фуд-Экспресс'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isLoading)
                const CircularProgressIndicator()
              else
                const Icon(Icons.local_shipping, size: 80, color: Colors.blue),
              const SizedBox(height: 30),
              
              // Текст с результатом
              Text(
                _resultText,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 40),

              // Кнопка выбора файла
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _pickAndUploadFile,
                icon: const Icon(Icons.file_upload),
                label: const Text('ВЫБРАТЬ ФАЙЛ EXCEL'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
