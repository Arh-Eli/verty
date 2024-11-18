import 'package:flutter/material.dart';

class KartaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Карта'),
        automaticallyImplyLeading: false, // Убираем стрелочку назад
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blueAccent, // Замените на нужный цвет или виджет
          child: Center(
            child: Text(
              'Здесь будет карта',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}
