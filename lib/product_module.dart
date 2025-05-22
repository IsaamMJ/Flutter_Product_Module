library product;

// 🌐 External API Exports
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
import 'routes/app_routes.dart';
import 'presentation/pages/product_list_page.dart';
import 'domain/entities/product.dart';

class ProductModule {
  static void init({
    required SupabaseClient supabaseClient,
    Future<void> Function(Product product)? onAddToCart,
  }) {
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

    // 🔹 Cart Connector
    final cartConnector = _HostCartConnector(onAddToCart);

    // 🔹 Controller
    Get.put<ProductController>(
      ProductController(
        Get.find<GetProductsUseCase>(),
        Get.find<AddProductUseCase>(),
        Get.find<DeleteProductUseCase>(),
        eventBus: Get.find<ProductEventBus>(),
        cartConnector: _HostCartConnector(onAddToCart),
      ),
      permanent: true,
    );

    // 🔹 Host-facing services
    Get.lazyPut<IProductService>(
          () => ProductService(Get.find<ProductController>()),
      fenix: true,
    );

    Get.lazyPut<ProductFacade>(
          () => ProductFacadeImpl(Get.find<ProductController>()),
      fenix: true,
    );
  }

  static List<GetPage> getRoutes() {
    return [
      GetPage(
        name: ProductRoutes.products,
        page: () => const ProductListPage(),
        binding: _EmptyProductBinding(),
        transition: Transition.noTransition,
        participatesInRootNavigator: false,
      ),
    ];
  }
}

class _EmptyProductBinding extends Bindings {
  @override
  void dependencies() {}
}

/// ✅ Correct implementation of ICartConnector
class _HostCartConnector implements ICartConnector {
  final Future<void> Function(Product product)? _onAddToCart;

  _HostCartConnector(this._onAddToCart);

  @override
  Future<void> onAddToCart(Product product) async {
    if (_onAddToCart != null) {
      await _onAddToCart!(product);
    }
  }
}
