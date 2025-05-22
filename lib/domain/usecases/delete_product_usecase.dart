// delete_product_usecase.dart
import '../repositories/product_repository.dart';

class DeleteProductUseCase {
  final ProductRepository repository;
  DeleteProductUseCase(this.repository);

  Future<void> call(String id) => repository.deleteProduct(id);
}