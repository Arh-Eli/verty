import 'package:flutter/material.dart';

class ZakazScreen extends StatelessWidget {
  final List<Order> orders = [
    Order(id: 1, status: 'Завершен', details: 'Детали заказа 1...'),
    Order(id: 2, status: 'В процессе', details: 'Детали заказа 2...'),
    Order(id: 3, status: 'Завершен', details: 'Детали заказа 3...'),
    Order(id: 4, status: 'Отменен', details: 'Детали заказа 4...'),
    Order(id: 5, status: 'В процессе', details: 'Детали заказа 5...'),
  ];

  @override
  Widget build(BuildContext context) {
    // Разделяем заказы на текущие и завершенные
    final currentOrders =
        orders.where((order) => order.status != 'Завершен').toList();
    final completedOrders =
        orders.where((order) => order.status == 'Завершен').toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Заказы'),
        automaticallyImplyLeading: false, // Убираем стрелочку назад
      ),
      body: ListView(
        children: [
          _buildOrderSection('Текущие заказы', currentOrders, context),
          _buildOrderSection('Завершенные заказы', completedOrders, context),
        ],
      ),
    );
  }

  Widget _buildOrderSection(
      String title, List<Order> orders, BuildContext context) {
    return ExpansionTile(
      title: Text(title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      children: orders.map((order) {
        return ListTile(
          title: Text('Заказ ${order.id} - ${order.status}'),
          onTap: () {
            // Показать детали заказа
            showDialog(
              context: context,
              builder: (context) => OrderDetailDialog(order: order),
            );
          },
        );
      }).toList(),
    );
  }
}

class Order {
  final int id;
  final String status;
  final String details;

  Order({
    required this.id,
    required this.status,
    required this.details,
  });
}

class OrderDetailDialog extends StatelessWidget {
  final Order order;

  OrderDetailDialog({required this.order});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Детали заказа ${order.id}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Статус: ${order.status}'),
          SizedBox(height: 8),
          Text('Информация о заказе: ${order.details}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Закрыть'),
        ),
      ],
    );
  }
}
