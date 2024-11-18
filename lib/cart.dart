class Brand {
  String name;
  double price;
  int quantity;
  bool inCart;

  Brand({
    required this.name,
    required this.price,
    this.quantity = 0,
    this.inCart = false,
  });
}

class Part {
  String name;
  List<Brand> brands;

  Part({
    required this.name,
    required this.brands,
  });
}

class Category {
  String name;
  List<Part> parts;

  Category({
    required this.name,
    required this.parts,
  });
}

// Пример данных
List<Category> getCategories() {
  return [
    Category(
      name: 'Двигатель',
      parts: [
        Part(
          name: 'Фильтр масла',
          brands: [
            Brand(name: 'Brand A', price: 150.0),
            Brand(name: 'Brand B', price: 200.0),
          ],
        ),
        Part(
          name: 'Фильтр воздуха',
          brands: [
            Brand(name: 'Brand C', price: 100.0),
            Brand(name: 'Brand D', price: 120.0),
          ],
        ),
      ],
    ),
    Category(
      name: 'Тормоза',
      parts: [
        Part(
          name: 'Тормозные колодки',
          brands: [
            Brand(name: 'Brand E', price: 300.0),
            Brand(name: 'Brand F', price: 350.0),
          ],
        ),
      ],
    ),
    // Добавьте дополнительные категории и запчасти по необходимости
  ];
}
