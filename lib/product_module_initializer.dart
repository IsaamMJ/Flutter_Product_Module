import 'package:supabase_flutter/supabase_flutter.dart';
import 'domain/entities/product.dart';
import 'product_module.dart';
import 'product_module_config.dart';

/// Initializes the Product Module with required dependencies.
class ProductModuleInitializer {
  static void init({
    required SupabaseClient supabaseClient,
    Future<void> Function(Product product)? onAddToCart,
  }) {
    final config = ProductModuleConfig(
      supabaseClient: supabaseClient,
      onAddToCart: onAddToCart,
    );

    ProductModule.init(config);
  }
}
