import 'fashion_model.dart';

class CheckoutArgs {
  final ProductModel product;
  final String size;
  final int quantity;
  final double price;

  CheckoutArgs({
    required this.product,
    required this.size,
    required this.quantity,
    required this.price,
  });
}
