import 'package:flutter/material.dart';

class UvedomleniaScreen extends StatefulWidget {
  @override
  _UvedomleniaScreenState createState() => _UvedomleniaScreenState();
}

class _UvedomleniaScreenState extends State<UvedomleniaScreen> {
  List<String> notifications =
      List.generate(10, (index) => 'Уведомление ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Уведомления'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Icon(Icons.notifications), // Иконка уведомления
              title: Text(notifications[index]),
              subtitle: Text('Статус заказа...'),
              trailing: IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  // Открываем меню с иконкой мусорки
                  _showDeleteOption(context, index);
                },
              ),
              onTap: () {
                // Действие при нажатии на уведомление
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(index: index + 1),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _showDeleteOption(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Удалить уведомление'),
          content:
              Text('Вы уверены, что хотите удалить "${notifications[index]}"?'),
          actions: <Widget>[
            TextButton(
              child: Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop(); // Закрыть диалог
              },
            ),
            TextButton(
              child: Text('Удалить'),
              onPressed: () {
                setState(() {
                  notifications
                      .removeAt(index); // Удаляем уведомление из списка
                });
                Navigator.of(context).pop(); // Закрыть диалог
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          'Уведомление "${notifications[index]}" удалено')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class DetailScreen extends StatelessWidget {
  final int index;

  DetailScreen({required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Детали уведомления $index'),
      ),
      body: Center(
        child: Text('Это детали уведомления $index'),
      ),
    );
  }
}
