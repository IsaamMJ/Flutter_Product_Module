import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../controller/product_controller.dart';
import '../../core/contracts/i_cart_connector.dart';
import '../../core/events/product_event_bus.dart'; // ✅ New import
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/add_product_usecase.dart';
import '../../domain/usecases/delete_product_usecase.dart';
import '../../domain/usecases/get_products_usecase.dart';

class ProductBinding extends Bindings {
  final SupabaseClient supabaseClient;
  final ICartConnector? cartConnector; // ✅ Optional injection via interface

  ProductBinding({
    required this.supabaseClient,
    this.cartConnector,
  });

  @override
  void dependencies() {
    // 🔹 Repository
    Get.put<ProductRepository>(
      ProductRepositoryImpl(supabaseClient),
      permanent: true,
    );

    // 🔹 Use Cases
    Get.lazyPut(() => GetProductsUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => AddProductUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => DeleteProductUseCase(Get.find()), fenix: true);

    // 🔹 Event Bus
    Get.put<ProductEventBus>(ProductEventBus(), permanent: true);

    // 🔹 Controller with injected connector and event bus
    Get.put<ProductController>(
      ProductController(
        Get.find(),
        Get.find(),
        Get.find(),
        eventBus: Get.find<ProductEventBus>(),
        cartConnector: cartConnector,
      ),
      permanent: false,
    );
  }
}
