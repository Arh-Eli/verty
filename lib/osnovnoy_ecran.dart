import 'package:flutter/material.dart';
import 'chat.dart'; // Импортируйте ваш экран чата
import 'karta.dart'; // Импортируйте ваш экран карты
import 'poisk.dart'; // Импортируйте ваш экран поиска
import 'profil.dart'; // Импортируйте ваш экран профиля
import 'uvedomlenia.dart'; // Импортируйте ваш экран уведомлений
import 'zakaz.dart'; // Импортируйте ваш экран заказов
import 'zapchasti.dart'; // Импортируйте ваш экран запчастей

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OsnovnoyEcran(),
      // Добавляем необходимые параметры для темы
      theme: ThemeData.light(), // Светлая тема
      darkTheme: ThemeData.dark(), // Темная тема
      themeMode: ThemeMode.light, // Режим темы по умолчанию
    );
  }
}

class OsnovnoyEcran extends StatefulWidget {
  @override
  _OsnovnoyEcranState createState() => _OsnovnoyEcranState();
}

class _OsnovnoyEcranState extends State<OsnovnoyEcran> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ZapchastiScreen(), // Экран запчастей
    ZakazScreen(), // Экран заказов
    KartaScreen(), // Экран карты
    ChatScreen(), // Экран чата
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor:
            Color(0xFF4A90E2), // Задаем грязно-голубой цвет для AppBar
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PoiskScreen()), // Поиск
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UvedomleniaScreen()), // Уведомления
              );
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfilScreen()), // Профиль
            );
          },
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Запчасти',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Заказы',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Карта',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Чат',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(
            0xFF4A90E2), // Задаем грязно-голубой цвет для BottomNavigationBar
        selectedItemColor: Colors.white, // Цвет выбранного элемента
        unselectedItemColor: Colors.white70, // Цвет невыбранного элемента
      ),
    );
  }
}
