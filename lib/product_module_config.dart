import 'package:supabase_flutter/supabase_flutter.dart';
import 'domain/entities/product.dart';
import 'core/contracts/i_cart_connector.dart';

class ProductModuleConfig {
  /// The Supabase client used by the module
  final SupabaseClient supabaseClient;

  /// Optional cart connector provided by the host
  final ICartConnector? cartConnector;

  ProductModuleConfig({
    required this.supabaseClient,
    this.cartConnector,
  });
}
