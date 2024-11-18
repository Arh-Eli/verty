import 'package:flutter/material.dart';

class PoiskScreen extends StatefulWidget {
  @override
  _PoiskScreenState createState() => _PoiskScreenState();
}

class _PoiskScreenState extends State<PoiskScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _errorMessage;
  List<String> _parts = [
    'Деталь 1',
    'Деталь 2',
    'Деталь 3',
    'Деталь 4',
    'Деталь 5',
  ];
  List<String> _searchResults = [];

  void _searchPart() {
    setState(() {
      _errorMessage = null; // Сброс ошибки при новом поиске
      if (_controller.text.isEmpty) {
        _errorMessage = 'Введите название детали';
        _searchResults.clear();
      } else {
        // Логика поиска детали
        _searchResults = _parts
            .where((part) =>
                part.toLowerCase().contains(_controller.text.toLowerCase()))
            .toList();

        if (_searchResults.isEmpty) {
          _errorMessage = 'Детали не найдены';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Поиск')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Введите деталь'),
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed: _searchPart, child: Text('Поиск')),
            if (_errorMessage != null)
              Column(
                children: [
                  Icon(Icons.sentiment_dissatisfied),
                  Text(_errorMessage!),
                ],
              ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_searchResults[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
