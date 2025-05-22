import 'package:get/get.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products_usecase.dart';
import '../../domain/usecases/add_product_usecase.dart';
import '../../domain/usecases/delete_product_usecase.dart';
import '../core/contracts/i_cart_connector.dart';
import '../core/events/product_events.dart';
import '../core/state/product_state.dart';
import '../core/events/product_event_bus.dart';


class ProductController extends GetxController {
  final GetProductsUseCase getProductsUseCase;
  final AddProductUseCase addProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  final ProductEventBus eventBus;
  final ICartConnector? cartConnector; // ✅ Uses interface now

  ProductController(
      this.getProductsUseCase,
      this.addProductUseCase,
      this.deleteProductUseCase, {
        required this.eventBus,
        this.cartConnector,
      });

  final Rx<ProductState> state = ProductState.empty().obs;

  List<Product> get products => state.value.products;
  bool get isLoading => state.value.isLoading;
  String? get errorMessage => state.value.errorMessage;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();

    if (cartConnector == null) {
      print('⚠️ ProductController: cartConnector is null (cart not connected)');
    } else {
      print('✅ ProductController: cartConnector is injected');
    }
  }

  Future<void> fetchProducts() async {
    state.value = state.value.copyWith(isLoading: true, errorMessage: null);
    try {
      final items = await getProductsUseCase();
      state.value = state.value.copyWith(products: items);
    } catch (_) {
      state.value = state.value.copyWith(errorMessage: 'Failed to load products');
      Get.snackbar('Error', 'Failed to load products');
    } finally {
      state.value = state.value.copyWith(isLoading: false);
    }
  }

  Future<void> createProduct({
    required String name,
    required double price,
    required String description,
    required String imageUrl,
  }) async {
    final product = Product(
      id: '',
      name: name,
      price: price,
      description: description,
      imageUrl: imageUrl,
    );

    try {
      await addProductUseCase(product);
      eventBus.emit(ProductAdded(product.id));
      await fetchProducts();
    } catch (_) {
      Get.snackbar('Error', 'Failed to create product');
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await deleteProductUseCase(id);
      eventBus.emit(ProductDeleted(id));
      final updated = products.where((p) => p.id != id).toList();
      state.value = state.value.copyWith(products: updated);
    } catch (_) {
      Get.snackbar('Error', 'Failed to delete product');
    }
  }

  Future<void> addToCart(Product product) async {
    if (cartConnector == null) {
      print('❌ Cannot add to cart: cartConnector is null');
      Get.snackbar('Unavailable', 'Cart not connected');
      return;
    }

    try {
      await cartConnector!.onAddToCart(product);
      Get.snackbar('Success', 'Added to cart');
    } catch (e) {
      print('❌ Error in addToCart: $e');
      Get.snackbar('Error', 'Could not add to cart');
    }
  }
}
