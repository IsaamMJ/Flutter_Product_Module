library product;

export 'presentation/pages/product_list_page.dart';
export 'presentation/bindings/product_binding.dart';
export 'routes/app_routes.dart';
export 'routes/product_pages.dart';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'controller/product_controller.dart';
import 'core/contracts/i_cart_connector.dart';
import 'core/events/product_event_bus.dart';
import 'core/facade/product_facade.dart';
import 'core/facade/product_facade_impl.dart';
import 'core/services/i_product_service.dart';
import 'core/services/product_service.dart';
import 'data/repositories/product_repository_impl.dart';
import 'domain/repositories/product_repository.dart';
import 'domain/usecases/add_product_usecase.dart';
import 'domain/usecases/delete_product_usecase.dart';
import 'domain/usecases/get_products_usecase.dart';
import 'domain/entities/product.dart';
import 'product_module_config.dart';

class ProductModule {
  /// Public access to module configuration for routes and DI
  static late final ProductModuleConfig config;

  static void init(ProductModuleConfig cfg) {
    config = cfg;

    // Repository
    Get.put<ProductRepository>(
      ProductRepositoryImpl(cfg.supabaseClient),
      permanent: true,
    );

    // Use cases
    Get.lazyPut(() => GetProductsUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => AddProductUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => DeleteProductUseCase(Get.find()), fenix: true);

    // Event bus
    Get.put<ProductEventBus>(ProductEventBus(), permanent: true);

    // Controller with DI
    Get.put<ProductController>(
      ProductController(
        Get.find(), // getProductsUseCase
        Get.find(), // addProductUseCase
        Get.find(), // deleteProductUseCase
        eventBus: Get.find<ProductEventBus>(),
        cartConnector: cfg.cartConnector,
      ),
      permanent: true,
    );

    // Services and facade
    Get.lazyPut<IProductService>(() => ProductService(Get.find()), fenix: true);
    Get.lazyPut<ProductFacade>(() => ProductFacadeImpl(Get.find()), fenix: true);
  }
}
