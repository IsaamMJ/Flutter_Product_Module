import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'product_module.dart';
import 'product_module_config.dart';
import 'domain/entities/product.dart';

class ProductModuleInitializer {
  static void init({
    required SupabaseClient supabaseClient,
    Future<void> Function(Product product)? onAddToCart,
  }) {
    ProductModule.init(
      ProductModuleConfig(
        supabaseClient: supabaseClient,
        onAddToCart: onAddToCart,
      ),
    );
  }
}
