abstract class ProductEvent {}

class ProductAdded extends ProductEvent {
  final String productId;
  ProductAdded(this.productId);
}

class ProductDeleted extends ProductEvent {
  final String productId;
  ProductDeleted(this.productId);
}
