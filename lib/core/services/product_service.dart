import '../../controller/product_controller.dart';
import '../../domain/entities/product.dart';
import 'i_product_service.dart';

class ProductService implements IProductService {
  final ProductController _controller;

  ProductService(this._controller);

  @override
  List<Product> get products => _controller.products;

  @override
  bool get isLoading => _controller.isLoading;

  @override
  String? get errorMessage => _controller.errorMessage;

  @override
  Future<void> fetchProducts() => _controller.fetchProducts();

  @override
  Future<void> createProduct({
    required String name,
    required double price,
    required String description,
    required String imageUrl,
  }) =>
      _controller.createProduct(
        name: name,
        price: price,
        description: description,
        imageUrl: imageUrl,
      );

  @override
  Future<void> deleteProduct(String id) => _controller.deleteProduct(id);

  @override
  Future<void> addToCart(Product product) => _controller.addToCart(product);
}
