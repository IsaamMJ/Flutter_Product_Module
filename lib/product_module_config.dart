import 'package:supabase_flutter/supabase_flutter.dart';
import 'domain/entities/product.dart';
import 'core/contracts/i_cart_connector.dart';

class ProductModuleConfig {
  final SupabaseClient supabaseClient;
  final Future<void> Function(Product product)? onAddToCart;

  ProductModuleConfig({
    required this.supabaseClient,
    this.onAddToCart,
  });

  /// ✅ Derived connector used internally by ProductModule and ProductPages
  ICartConnector? get cartConnector =>
      onAddToCart != null ? _HostCartConnector(onAddToCart!) : null;
}

class _HostCartConnector implements ICartConnector {
  final Future<void> Function(Product product) _onAddToCart;

  _HostCartConnector(this._onAddToCart);

  @override
  Future<void> onAddToCart(Product product) async {
    await _onAddToCart(product);
  }
}
