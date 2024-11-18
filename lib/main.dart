import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'phone.dart';
import 'osnovnoy_ecran.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация Supabase
  await Supabase.initialize(
    url: 'https://miudifkhwtmbmyljkibd.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1pdWRpZmtod3RtYm15bGpraWJkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE5MTc1NjYsImV4cCI6MjA0NzQ5MzU2Nn0.3MfEgVIc3fQVyMhctX41zT6NU3Du3xV3uZaGl9EuuEo',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Verty',
      theme: ThemeData(
        primarySwatch: Colors.orange, // Добавление темы для приложения
      ),
      home: HomeScreen(), // домашний экран
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Verty'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        PhoneInputScreen(), // Переход на экран phone.dart
                  ),
                );
              },
              child: Text('Войти'), // Изменение текста кнопки
            ),
            SizedBox(height: 20), // Отступ между кнопками
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        OsnovnoyEcran(), // Переход на основной экран
                  ),
                );
              },
              child: Text('Для Админа'), // Текст кнопки для администратора
            ),
          ],
        ),
      ),
    );
  }
}
