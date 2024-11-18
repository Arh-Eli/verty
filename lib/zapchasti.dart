import 'package:flutter/material.dart';
import 'cart.dart'; // Импортируем файл с классами и функциями для работы с запчастями
import 'korzina.dart'; // Импортируем экран корзины

class ZapchastiScreen extends StatefulWidget {
  @override
  _ZapchastiScreenState createState() => _ZapchastiScreenState();
}

class _ZapchastiScreenState extends State<ZapchastiScreen> {
  List<Category> categories = []; // Список категорий
  List<Map<String, dynamic>> cartItems = []; // Список элементов в корзине

  @override
  void initState() {
    super.initState();
    categories = getCategories(); // Получаем категории из cart.dart
  }

  void _addToCart(Brand brand) {
    setState(() {
      cartItems.add({
        'partName': brand.name,
        'price': brand.price,
        'quantity': brand.quantity, // Отправляем текущее количество
      });
      brand.inCart = true; // Устанавливаем статус товара в корзине
      // Не сбрасываем количество здесь
    });
  }

  void _removeFromCart(Brand brand) {
    setState(() {
      // Удаляем элемент из корзины
      cartItems.removeWhere((item) => item['partName'] == brand.name);
      brand.inCart = false; // Устанавливаем статус товара как не в корзине

      // Сбрасываем количество запчастей до 0
      brand.quantity = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Запчасти'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Korzina(
                        cartItems: cartItems)), // Переход на экран корзины
              );
            },
          ),
        ],
        automaticallyImplyLeading: false, // Убираем стрелочку назад
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return ExpansionTile(
                title: Text(categories[index].name),
                children: categories[index].parts.map((part) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: part.brands.map((brand) {
                      return ListTile(
                        title: Text(brand.name),
                        subtitle: Text('Цена: ${brand.price} ₽'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (brand.quantity > 0) brand.quantity--;
                                });
                              },
                            ),
                            Text('${brand.quantity}'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  brand.quantity++;
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                brand.inCart
                                    ? Icons.remove_shopping_cart
                                    : Icons.add_shopping_cart,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (brand.inCart) {
                                    _removeFromCart(
                                        brand); // Удаляем из корзины
                                  } else if (brand.quantity > 0) {
                                    _addToCart(
                                        brand); // Добавляем в корзину с текущим количеством
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
