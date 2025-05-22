import 'product_facade.dart';
import '../../controller/product_controller.dart';
import '../../domain/entities/product.dart';

class ProductFacadeImpl implements ProductFacade {
  final ProductController controller;

  ProductFacadeImpl(this.controller);

  @override
  List<Product> get products => controller.products;

  @override
  bool get isLoading => controller.isLoading;

  @override
  String? get errorMessage => controller.errorMessage;

  @override
  Future<void> fetchProducts() => controller.fetchProducts();

  @override
  Future<void> createProduct({
    required String name,
    required double price,
    required String description,
    required String imageUrl,
  }) =>
      controller.createProduct(
        name: name,
        price: price,
        description: description,
        imageUrl: imageUrl,
      );

  @override
  Future<void> deleteProduct(String id) => controller.deleteProduct(id);

  @override
  Future<void> addToCart(Product product) => controller.addToCart(product);
}
