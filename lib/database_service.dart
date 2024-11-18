import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Метод для добавления данных
  Future<void> addOrder(String name, int price) async {
    final response = await _supabase.from('orders').insert({
      'name': name,
      'price': price,
    });

    // Проверка статуса ответа
    if (response.hasError) {
      throw Exception('Ошибка при добавлении данных: ${response.statusText}');
    }
  }

  // Метод для получения данных
  Future<List<Map<String, dynamic>>> getOrders() async {
    final response = await _supabase.from('orders').select();

    // Проверка статуса ответа
    if (response.hasError) {
      throw Exception('Ошибка при получении данных: ${response.statusText}');
    }

    // Преобразование данных
    return (response as List).map((e) => e as Map<String, dynamic>).toList();
  }
}
