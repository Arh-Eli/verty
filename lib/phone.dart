import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'registration.dart'; // Импортируйте ваш экран регистрации
import 'osnovnoy_ecran.dart'; // Импортируйте ваш основной экран

class PhoneInputScreen extends StatefulWidget {
  @override
  _PhoneInputScreenState createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String _selectedCountryCode = '+7';

  final List<String> countryCodes = [
    '+1',
    '+7',
    '+44',
    '+49',
    '+33',
    '+81',
    '+86',
  ];

  final Map<String, int> countryPhoneLength = {
    '+1': 10,
    '+7': 10,
    '+44': 10,
    '+49': 10,
    '+33': 9,
    '+81': 10,
    '+86': 11,
  };

  void _checkUserAndProceed() {
    String phoneNumber = _phoneController.text.replaceAll(RegExp(r'D'), '');

    if (phoneNumber.isNotEmpty &&
        phoneNumber.length == (countryPhoneLength[_selectedCountryCode] ?? 0)) {
      bool isRegistered = checkIfUserRegistered(phoneNumber);

      if (isRegistered) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OsnovnoyEcran()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RegistrationScreen()),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Введите корректный номер телефона')),
      );
    }
  }

  bool checkIfUserRegistered(String phoneNumber) {
    return phoneNumber == '7000000000'; // Пример зарегистрированного номера
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Введите номер телефона'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Номер телефона',
                prefixIcon: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCountryCode,
                    items: countryCodes.map((String code) {
                      return DropdownMenuItem<String>(
                        value: code,
                        child: Text(code),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCountryCode = newValue!;
                        _phoneController.clear();
                      });
                    },
                  ),
                ),
                prefixText: ' ',
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(
                    countryPhoneLength[_selectedCountryCode]),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkUserAndProceed,
              child: Text('Проверить'),
            ),
          ],
        ),
      ),
    );
  }
}
