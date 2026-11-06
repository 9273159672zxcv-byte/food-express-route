import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const FoodExpressApp());
}

class FoodExpressApp extends StatelessWidget {
  const FoodExpressApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Фуд-Экспресс',
      theme: ThemeData(
        primaryColor: const Color(0xFFE53935),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _result = '';

  Future<void> _pickAndUploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );

    if (result != null) {
      setState(() {
        _result = 'Загрузка...';
      });
      
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://95.163.230.180:8081/upload'),
      );
      
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        result.files.single.path!,
      ));

      try {
        var response = await request.send();
        var responseData = await response.stream.bytesToString();
        var json = jsonDecode(responseData);
        
        setState(() {
          if (json['status'] == 'success') {
            _result = 'Маршрут построен! Порядок точек:\n\n' + json['optimized_order'].join('\n');
          } else {
            _result = 'Ошибка: ' + (json['error'] ?? 'Неизвестная ошибка');
          }
        });
      } catch (e) {
        setState(() {
          _result = 'Ошибка сети: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE53935),
        title: const Text(
          'Фуд-Экспресс: Маршрут',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(Icons.local_shipping, size: 80, color: Color(0xFFE53935)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickAndUploadFile,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE53935),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text('ВЫБРАТЬ ФАЙЛ EXCEL', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_result, style: const TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
