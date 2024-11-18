import 'package:flutter/material.dart';
import 'osnovnoy_ecran.dart';
import 'main.dart';

class ProfilScreen extends StatefulWidget {
  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  String lastName = 'Иванов';
  String firstName = 'Иван';
  String middleName = 'Иванович';
  String phone = '+7 (999) 999-99-99';
  String email = 'ivanov@example.com';
  String birthDate = '01.01.1990';

  List<Map<String, String>> cards = [
    {
      'number': '**** **** **** 1234',
      'owner': 'Иванов Иван',
      'expiry': '12/25'
    },
    {
      'number': '**** **** **** 5678',
      'owner': 'Иванов Иван',
      'expiry': '11/24'
    },
  ];

  bool isDarkTheme = false; // Переменная для хранения текущей темы
  String currentVersion = '1.0.0'; // Текущая версия приложения
  String latestVersion = '1.1.0'; // Актуальная версия приложения

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль', style: TextStyle(fontFamily: 'Roboto')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => OsnovnoyEcran()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Прямоугольник с ФИО и номером телефона
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: Offset(0, 3), // Положение тени
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$lastName $firstName $middleName',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(phone,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                  SizedBox(height: 8)
                ],
              ),
            ),
            SizedBox(height: 20),

            // Кнопки-надписи с одинаковым интервалом
            _buildOptionButton('Изменить контактную информацию', Icons.edit,
                _showContactInfoDialog),
            _buildOptionButton(
                'Оплата', Icons.payment, _showPaymentCardsDialog),
            _buildOptionButton(
                'Безопасность', Icons.lock, _showSecurityOptionsDialog),
            _buildOptionButton('Тема', Icons.palette, _showThemeDialog),
            _buildOptionButton('О приложении', Icons.info, _showAboutAppDialog),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: _confirmDeleteProfile,
              child: Text('Удалить профиль'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
            SizedBox(height: 10),

            ElevatedButton(
              onPressed: _confirmLogout,
              child: Text('Выйти из приложения'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue),
            SizedBox(width: 10),
            Text(title, style: TextStyle(fontSize: 18, color: Colors.blue)),
          ],
        ),
      ),
    );
  }

  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Выберите тему'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Светлая тема'),
                onTap: () {
                  setState(() {
                    isDarkTheme = false; // Устанавливаем светлую тему
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Темная тема'),
                onTap: () {
                  setState(() {
                    isDarkTheme = true; // Устанавливаем темную тему
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showContactInfoDialog() {
    final lastNameController = TextEditingController(text: lastName);
    final firstNameController = TextEditingController(text: firstName);
    final middleNameController = TextEditingController(text: middleName);
    final phoneController = TextEditingController(text: phone);
    final emailController = TextEditingController(text: email);
    final birthDateController = TextEditingController(text: birthDate);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Изменить контактную информацию'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                    controller: lastNameController,
                    decoration: InputDecoration(labelText: 'Фамилия')),
                TextField(
                    controller: firstNameController,
                    decoration: InputDecoration(labelText: 'Имя')),
                TextField(
                    controller: middleNameController,
                    decoration: InputDecoration(labelText: 'Отчество')),
                TextField(
                    controller: phoneController,
                    decoration: InputDecoration(labelText: 'Телефон')),
                TextField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email')),
                TextField(
                    controller: birthDateController,
                    decoration: InputDecoration(labelText: 'Дата рождения')),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  lastName = lastNameController.text;
                  firstName = firstNameController.text;
                  middleName = middleNameController.text;
                  phone = phoneController.text;
                  email = emailController.text;
                  birthDate = birthDateController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }

  void _showPaymentCardsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Сохранённые карты'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: cards.map((card) {
            return ListTile(
              title: Text(card['owner']!),
              subtitle: Text(card['number']!),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    cards.remove(card);
                  });
                  Navigator.of(context).pop();
                  _showPaymentCardsDialog(); // Обновляем диалог после удаления
                },
              ),
            );
          }).toList(),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Закрыть')),
        ],
      ),
    );
  }

  void _showSecurityOptionsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Безопасность'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Вход по пин-коду'),
              onTap: () {
                // Логика для входа по пин-коду
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('Вход по отпечатку пальца'),
              onTap: () {
                // Логика для входа по отпечатку пальца
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('Вход по Face ID'),
              onTap: () {
                // Логика для входа по Face ID
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Закрыть')),
        ],
      ),
    );
  }

  void _showAboutAppDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('О приложении'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Правила приложения'),
                onTap: () {
                  // Открыть правила приложения
                },
              ),
              ListTile(
                title: Text('Политика конфиденциальности'),
                onTap: () {
                  // Открыть политику конфиденциальности
                },
              ),
              SizedBox(height: 10),
              Text('Текущая версия приложения: $currentVersion'),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _checkForUpdates,
                child: Text('Проверка обновления'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Закрыть'),
            ),
          ],
        );
      },
    );
  }

  void _checkForUpdates() {
    if (currentVersion != latestVersion) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Доступно обновление!'),
            content: Text(
                'Версия $latestVersion доступна для загрузки. Хотите обновить?'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  // Логика для обновления приложения
                  Navigator.of(context).pop();
                },
                child: Text('Обновить'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Отмена'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Установлена актуальная версия'),
            content: Text('Вы используете последнюю версию приложения.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Закрыть'),
              ),
            ],
          );
        },
      );
    }
  }

  void _confirmDeleteProfile() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Подтверждение удаления профиля'),
        content: Text('Вы уверены, что хотите удалить профиль?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Отмена')),
          ElevatedButton(
              onPressed: () {
                // Логика для удаления профиля
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: Text('Удалить')),
        ],
      ),
    );
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Подтверждение выхода'),
        content: Text('Вы уверены, что хотите выйти из приложения?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Отмена')),
          ElevatedButton(
              onPressed: () {
                // Логика для выхода из приложения
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: Text('Выйти')),
        ],
      ),
    );
  }
}
