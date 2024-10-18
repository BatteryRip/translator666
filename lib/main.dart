import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:translator_plus/src/google_translator.dart';

void main() {
  final translator = GoogleTranslator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Translate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Translate'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GoogleTranslator translator = GoogleTranslator();
  final TextEditingController _textController = TextEditingController();
  String _translatedText = '';

  void _translateToEnglish() async {
    final translation = await translator.translate(_textController.text, from: 'ru', to: 'en');
    setState(() {
      _translatedText = translation.text;
    });
  }

  void _translateToRussian() async {
    final translation = await translator.translate(_textController.text, from: 'en', to: 'ru');
    setState(() {
      _translatedText = translation.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Введите текст',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _translateToEnglish,
                  child: const Text('Перевести на английский'),
                ),
                ElevatedButton(
                  onPressed: _translateToRussian,
                  child: const Text('Перевести на русский'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Результат перевода',
              ),
              controller: TextEditingController(text: _translatedText),
              readOnly: true,
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}