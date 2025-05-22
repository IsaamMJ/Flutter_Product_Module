import 'package:supabase_flutter/supabase_flutter.dart';
import 'domain/entities/product.dart';

class ProductModuleConfig {
  final SupabaseClient supabaseClient;
  final Future<void> Function(Product product)? onAddToCart;

  ProductModuleConfig({
    required this.supabaseClient,
    this.onAddToCart,
  });
}
