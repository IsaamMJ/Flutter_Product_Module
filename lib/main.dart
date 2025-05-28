import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'routes/product_pages.dart';
import 'routes/app_routes.dart';
import 'domain/entities/product.dart';
import 'core/contracts/i_cart_connector.dart';
import 'product_module.dart';
import 'product_module_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize Supabase
  await Supabase.initialize(
    url: 'https://rdjdvatbbhwwzjtqvdru.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJkamR2YXRiYmh3d3pqdHF2ZHJ1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc0NTY5MjUsImV4cCI6MjA2MzAzMjkyNX0.JG2obBbs78w3WpIjXwT91SvpHIsC7H8axnw7mpfepWA',
  );

  // ✅ Initialize Product Module with mock cart connector
  ProductModule.init(
    ProductModuleConfig(
      supabaseClient: Supabase.instance.client,
      cartConnector: _MockCartConnector(),
    ),
  );

  runApp(const ProductModuleApp());
}

class ProductModuleApp extends StatelessWidget {
  const ProductModuleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Product Module Preview',
      debugShowCheckedModeBanner: false,
      initialRoute: ProductRoutes.products,
      getPages: ProductPages.routes(),
    );
  }
}

// ✅ Mock ICartConnector implementation
class _MockCartConnector implements ICartConnector {
  @override
  Future<void> onAddToCart(Product product) async {
    debugPrint('🧪 [MockCartConnector] Added to cart: ${product.name}');
    Get.snackbar(
      'Preview Cart',
      '${product.name} added (mock)',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade700,
      colorText: Colors.white,
    );
  }
}
