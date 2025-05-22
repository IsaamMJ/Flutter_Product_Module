import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<List<Product>> call({String? sortBy}) async {
    final all = await repository.getProducts();

    if (sortBy != null && sortBy == 'price') {
      all.sort((a, b) => a.price.compareTo(b.price));
    }

    return all;
  }
}
