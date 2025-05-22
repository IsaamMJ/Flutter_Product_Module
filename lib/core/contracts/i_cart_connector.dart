import '../../../domain/entities/product.dart';

abstract class ICartConnector {
  Future<void> onAddToCart(Product product);
}
