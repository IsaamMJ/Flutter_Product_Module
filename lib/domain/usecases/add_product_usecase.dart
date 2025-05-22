// add_product_usecase.dart
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class AddProductUseCase {
  final ProductRepository repository;
  AddProductUseCase(this.repository);

  Future<void> call(Product product) => repository.addProduct(product);
}