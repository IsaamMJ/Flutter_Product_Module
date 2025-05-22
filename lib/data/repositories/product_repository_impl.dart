import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final SupabaseClient client;

  ProductRepositoryImpl(this.client);

  @override
  Future<List<Product>> getProducts() async {
    final response = await client.from('products').select();
    final data = response as List<dynamic>;

    return data.map((item) {
      return Product(
        id: item['id'],
        name: item['name'],
        price: (item['price'] as num).toDouble(),
        description: item['description'],
        imageUrl: item['image_url'],
      );
    }).toList();
  }


  @override
  Future<void> deleteProduct(String id) async {
    await client.from('products').delete().eq('id', id);
  }



  @override
  Future<void> addProduct(Product product) async {
    await client.from('products').insert({
      'name': product.name,
      'price': product.price,
      'description': product.description,
      'image_url': product.imageUrl,
    });
  }
}
