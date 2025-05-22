// lib/product_module/core/state/product_state.dart

import '../../domain/entities/product.dart';

class ProductState {
  final List<Product> products;
  final bool isLoading;
  final String? errorMessage;

  const ProductState({
    required this.products,
    required this.isLoading,
    this.errorMessage,
  });

  /// Initial empty state
  factory ProductState.empty() => const ProductState(
    products: [],
    isLoading: false,
    errorMessage: null,
  );

  /// Create a copy of the state with optional overrides
  ProductState copyWith({
    List<Product>? products,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ProductState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
