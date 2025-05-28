import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../presentation/pages/product_list_page.dart';
import '../presentation/bindings/product_binding.dart';
import '../product_module.dart'; // ✅ Access ProductModule.config

class ProductPages {
  static List<GetPage> routes() {
    final supabaseClient = ProductModule.config.supabaseClient;
    final cartConnector = ProductModule.config.cartConnector;

    return [
      GetPage(
        name: '/products',
        page: () => const ProductListPage(),
        binding: ProductBinding(
          supabaseClient: supabaseClient,
          cartConnector: cartConnector,
        ),
      ),
    ];
  }
}
