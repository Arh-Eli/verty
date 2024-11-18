import 'package:flutter/material.dart';
import 'oplata.dart'; // Импортируем экран оплаты

class Korzina extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const Korzina({Key? key, required this.cartItems}) : super(key: key);

  @override
  _KorzinaState createState() => _KorzinaState();
}

class _KorzinaState extends State<Korzina> {
  void _incrementQuantity(int index) {
    setState(() {
      widget.cartItems[index]['quantity']++;
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (widget.cartItems[index]['quantity'] > 1) {
        widget.cartItems[index]['quantity']--;
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      // Сбрасываем количество на экране запчастей
      // Здесь можно добавить логику, если у вас есть доступ к объектам запчастей
      // Например, если у вас есть список parts, можно сбросить их количество
      // parts.firstWhere((part) => part.name == widget.cartItems[index]['partName']).quantity = 0;

      widget.cartItems.removeAt(index);
    });
  }

  double _calculateTotal() {
    return widget.cartItems.fold(0.0, (total, item) {
      return total + (item['price'] * item['quantity']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Корзина'),
      ),
      body: widget.cartItems.isEmpty
          ? Center(child: Text('Корзина пуста'))
          : ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                var item = widget.cartItems[index];
                double totalPrice = item['price'] * item['quantity'];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text('${item['partName']} - ${item['brandName']}'),
                    subtitle: Text(
                        'Цена: ${totalPrice.toStringAsFixed(2)}'), // Общая цена
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () => _decrementQuantity(index),
                        ),
                        Text('${item['quantity']}'), // Отображаем количество
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => _incrementQuantity(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _removeItem(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Итого: ${_calculateTotal().toStringAsFixed(2)}'),
              ElevatedButton(
                onPressed: () {
                  if (widget.cartItems.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PaymentScreen(cartItems: widget.cartItems)),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Корзина пуста!')));
                  }
                },
                child: Text('Оплатить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
