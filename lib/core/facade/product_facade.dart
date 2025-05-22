import '../../domain/entities/product.dart';

abstract class ProductFacade {
  List<Product> get products;
  bool get isLoading;
  String? get errorMessage;

  Future<void> fetchProducts();
  Future<void> createProduct({
    required String name,
    required double price,
    required String description,
    required String imageUrl,
  });
  Future<void> deleteProduct(String id);
  Future<void> addToCart(Product product);
}
