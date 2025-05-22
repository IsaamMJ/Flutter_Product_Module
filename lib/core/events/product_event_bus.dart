import 'dart:async';
import 'product_events.dart';

class ProductEventBus {
  final _controller = StreamController<ProductEvent>.broadcast();

  Stream<ProductEvent> get events => _controller.stream;

  void emit(ProductEvent event) {
    _controller.add(event);
  }

  void dispose() {
    _controller.close();
  }
}
