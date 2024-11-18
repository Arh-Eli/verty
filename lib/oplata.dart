import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  PaymentScreen({required this.cartItems});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedPaymentMethod;
  String? selectedBank;
  bool saveCardInfo = false;

  final List<String> banks = [
    'Сбербанк',
    'Тинькофф',
    'ВТБ',
    'Альфа-Банк',
  ];

  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  void _processPayment() {
    // Здесь должна быть логика обработки платежа
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Оплата успешна!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Оплата'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Выберите способ оплаты:'),
              ListTile(
                title: Text('Оплата по СБП'),
                leading: Radio<String>(
                  value: 'sbp',
                  groupValue: selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentMethod = value;
                      selectedBank = null; // сбрасываем выбранный банк
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Оплата по карте'),
                leading: Radio<String>(
                  value: 'card',
                  groupValue: selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentMethod = value;
                    });
                  },
                ),
              ),
              if (selectedPaymentMethod == 'sbp') ...[
                DropdownButton<String>(
                  hint: Text('Выберите банк'),
                  value: selectedBank,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedBank = newValue;
                    });
                    // Здесь можно добавить логику для открытия приложения банка
                  },
                  items: banks.map<DropdownMenuItem<String>>((String bank) {
                    return DropdownMenuItem<String>(
                      value: bank,
                      child: Text(bank),
                    );
                  }).toList(),
                ),
              ] else if (selectedPaymentMethod == 'card') ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: cardNumberController,
                        decoration: InputDecoration(labelText: 'Номер карты'),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: cardHolderController,
                        decoration:
                            InputDecoration(labelText: 'Владелец карты'),
                      ),
                      TextField(
                        controller: expiryDateController,
                        decoration:
                            InputDecoration(labelText: 'Срок действия (MM/YY)'),
                        keyboardType: TextInputType.datetime,
                      ),
                      TextField(
                        controller: cvvController,
                        decoration: InputDecoration(labelText: 'CVV'),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ],
              ElevatedButton(
                onPressed: _processPayment,
                child: Text('Подтвердить оплату'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
