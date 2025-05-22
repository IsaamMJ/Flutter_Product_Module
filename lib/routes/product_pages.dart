import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/contracts/i_cart_connector.dart';
import '../presentation/pages/product_list_page.dart';
import '../presentation/bindings/product_binding.dart';

class ProductPages {
  static List<GetPage> routes({
    required SupabaseClient supabaseClient,
    ICartConnector? cartConnector, // ✅ Clean abstraction for cart
  }) {
    return [
      GetPage(
        name: '/products',
        page: () => const ProductListPage(),
        binding: ProductBinding(
          supabaseClient: supabaseClient,
          cartConnector: cartConnector, // ✅ Pass interface directly
        ),
      ),
    ];
  }
}
