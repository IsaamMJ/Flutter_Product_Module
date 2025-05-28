import 'package:supabase_flutter/supabase_flutter.dart';
import 'domain/entities/product.dart';
import 'product_module.dart';
import 'product_module_config.dart';
import 'core/contracts/i_cart_connector.dart';

class ProductModuleInitializer {
  static void init({
    required SupabaseClient supabaseClient,
    ICartConnector? cartConnector,
  }) {
    final config = ProductModuleConfig(
      supabaseClient: supabaseClient,
      cartConnector: cartConnector,
    );

    ProductModule.init(config);
  }
}
