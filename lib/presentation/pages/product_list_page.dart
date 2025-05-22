import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/product_controller.dart';
import '../widgets/product_add_dialog.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController c = Get.find<ProductController>();

    return Scaffold(
      appBar: AppBar(title: const Text('All Products')),
      body: Obx(() {
        final state = c.state.value;

        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.products.isEmpty) {
          return const Center(
            child: Text(
              'No products available.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: state.products.length,
          itemBuilder: (_, i) {
            final p = state.products[i];

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: p.imageUrl.isNotEmpty &&
                      Uri.tryParse(p.imageUrl)?.hasAbsolutePath == true
                      ? Image.network(
                    p.imageUrl,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                  )
                      : Container(
                    width: 56,
                    height: 56,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported),
                  ),
                ),
                title: Text(p.name),
                subtitle: Text('\$${p.price.toStringAsFixed(2)}'),
                trailing: Wrap(
                  spacing: 8,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => c.deleteProduct(p.id),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_shopping_cart),
                      onPressed: () => c.addToCart(p),
                    ),
                  ],
                ),
                onTap: () => Get.snackbar(p.name, p.description),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddProductDialog(context, c),
        child: const Icon(Icons.add),
      ),
    );
  }
}
