import 'product_model.dart';

class CartItemModel {
  final ProductModel product;
  int quantity;

  CartItemModel({
    required this.product,
    this.quantity = 1,
  });

  double get total => product.price * quantity;
}

class OrderModel {
  final String id;
  final String customerId;
  final List<CartItemModel> items;
  final double subtotal;
  final double deliveryCharge;
  final double totalAmount;
  final String deliveryAddress;
  final String paymentMethod;
  final String paymentStatus; // 'Initiated', 'Pending', 'Successful', 'Failed'
  String orderStatus; // 'Pending', 'Confirmed', 'Processing', 'Shipped', 'Delivered', 'Cancelled'
  final DateTime orderDate;

  OrderModel({
    required this.id,
    required this.customerId,
    required this.items,
    required this.subtotal,
    required this.deliveryCharge,
    required this.totalAmount,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.orderStatus,
    required this.orderDate,
  });
}
