import 'package:supabase_flutter/supabase_flutter.dart';
import 'domain/entities/product.dart';
import 'core/contracts/i_cart_connector.dart';

class ProductModuleConfig {
  /// The Supabase client used throughout the product module.
  final SupabaseClient supabaseClient;

  /// Optional callback to handle 'Add to Cart' actions.
  final Future<void> Function(Product product)? onAddToCart;

  ProductModuleConfig({
    required this.supabaseClient,
    this.onAddToCart,
  });

  /// Derived connector used internally for cart interactions.
  ICartConnector? get cartConnector =>
      onAddToCart != null ? _HostCartConnector(onAddToCart!) : null;
}

/// Internal adapter that bridges the `onAddToCart` callback
/// with the `ICartConnector` interface.
class _HostCartConnector implements ICartConnector {
  final Future<void> Function(Product product) _onAddToCart;

  _HostCartConnector(this._onAddToCart);

  @override
  Future<void> onAddToCart(Product product) async {
    await _onAddToCart(product);
  }
}
