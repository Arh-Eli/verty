import 'package:flutter/material.dart';
import 'osnovnoy_ecran.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  DateTime? _birthDate;

  @override
  void dispose() {
    _lastNameController.dispose();
    _firstNameController.dispose();
    _middleNameController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите email';
    }
    const pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Введите корректный email';
    }
    return null;
  }

  String? _validateBirthDate(String? value) {
    if (_birthDate == null) {
      return 'Выберите дату рождения';
    }
    final age = DateTime.now().year - _birthDate!.year;
    if (age < 18) {
      return 'Вы должны быть не младше 18 лет';
    }
    return null;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthDate = picked;
        _birthDateController.text =
            "${picked.toLocal()}".split(' ')[0]; // Форматирование даты
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Обработка данных
      print('Фамилия: ${_lastNameController.text}');
      print('Имя: ${_firstNameController.text}');
      print('Отчество: ${_middleNameController.text}');
      print('Email: ${_emailController.text}');
      print('Дата рождения: ${_birthDateController.text}');

      // Здесь можно добавить логику для регистрации пользователя

      // Перенаправление на основной экран после успешной регистрации
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => OsnovnoyEcran()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Регистрация')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Фамилия'),
                validator: (value) =>
                    value?.isEmpty == true ? 'Введите фамилию' : null,
              ),
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'Имя'),
                validator: (value) =>
                    value?.isEmpty == true ? 'Введите имя' : null,
              ),
              TextFormField(
                controller: _middleNameController,
                decoration:
                    InputDecoration(labelText: 'Отчество (необязательно)'),
              ),
              TextFormField(
                controller: _birthDateController,
                decoration: InputDecoration(
                  labelText: 'Дата рождения',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                readOnly: true,
                validator: _validateBirthDate,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: _validateEmail,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Зарегистрироваться'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
