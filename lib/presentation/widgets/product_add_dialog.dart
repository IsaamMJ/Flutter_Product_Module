import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/product_controller.dart';

void showAddProductDialog(BuildContext context, ProductController controller) {
  final nameCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final imgCtrl = TextEditingController();

  Get.defaultDialog(
    title: 'Add Product',
    content: SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          TextField(
            controller: nameCtrl,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: priceCtrl,
            decoration: const InputDecoration(labelText: 'Price'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: descCtrl,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: imgCtrl,
            decoration: const InputDecoration(labelText: 'Image URL'),
          ),
        ],
      ),
    ),
    textConfirm: 'Save',
    textCancel: 'Cancel',
    confirmTextColor: Colors.white,
    onConfirm: () {
      final price = double.tryParse(priceCtrl.text) ?? -1;
      if (nameCtrl.text.trim().isEmpty || price <= 0) {
        Get.snackbar('Invalid Input', 'Please enter a valid name and price');
        return;
      }

      controller.createProduct(
        name: nameCtrl.text.trim(),
        price: price,
        description: descCtrl.text.trim(),
        imageUrl: imgCtrl.text.trim(),
      );
      Get.back(); // Close dialog
    },
  );
}
