import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/product_model.dart';
import '../models/cart_order_model.dart';
import '../models/chat_notification_model.dart';
import '../models/quran_prayer_model.dart';
import '../core/constants/app_constants.dart';
import '../core/constants/quran_data.dart';

class MockDatabaseService extends ChangeNotifier {
  // Current logged in user
  UserModel? currentUser;

  // Users
  final List<UserModel> users = [
    UserModel(
      id: 'u1',
      fullName: 'Customer Khan',
      mobileNumber: '01711122233',
      email: 'customer@khan.com',
      currentAddress: 'Dhaka, Bangladesh',
      role: 'Customer',
    ),
    UserModel(
      id: 'u2',
      fullName: 'Seller Electronics Ltd',
      mobileNumber: '01822233344',
      email: 'seller@khan.com',
      currentAddress: 'Agrabad, Chattogram',
      role: 'Seller',
    ),
    UserModel(
      id: 'u3',
      fullName: 'Admin Khan Commerce',
      mobileNumber: '01933344455',
      email: 'admin@khan.com',
      currentAddress: 'Head Office, Dhaka',
      role: 'Administrator',
    ),
  ];

  // Products (Approved products appear in marketplace)
  final List<ProductModel> products = [
    ProductModel(
      id: 'p1',
      title: 'Smart LED 4K TV 55 inch',
      category: 'Electronics',
      price: 65000.0,
      imageUrl: 'https://images.unsplash.com/photo-1593784991095-a205069470b6?auto=format&fit=crop&w=600&q=80',
      description: 'Ultra HD 4K Smart LED television with vibrant display and built-in streaming apps.',
      sellerId: 'u2',
      sellerName: 'Seller Electronics Ltd',
      isApproved: true,
      stockStatus: 'In Stock',
      authorizationInfo: 'Authorized Distributor License #BD-9921',
    ),
    ProductModel(
      id: 'p2',
      title: 'Pro Gaming Laptop 16GB RAM',
      category: 'Computers & Laptops',
      price: 95000.0,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&w=600&q=80',
      description: 'High performance gaming and professional laptop with latest processor and dedicated GPU.',
      sellerId: 'u2',
      sellerName: 'Seller Electronics Ltd',
      isApproved: true,
      stockStatus: 'In Stock',
      authorizationInfo: 'Manufacturer Direct Authorized Partner',
    ),
    ProductModel(
      id: 'p3',
      title: 'Islamic Studies & Quranic Guide Book',
      category: 'Books & Publications',
      price: 450.0,
      imageUrl: 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=600&q=80',
      description: 'Comprehensive guide to Quranic teachings, jurisprudence and moral values.',
      sellerId: 'u2',
      sellerName: 'Seller Electronics Ltd',
      isApproved: true,
      stockStatus: 'In Stock',
      authorizationInfo: 'Publisher Copyright Verification #BK-4412',
    ),
  ];

  // Listing Submissions
  final List<ListingSubmissionModel> submissions = [
    ListingSubmissionModel(
      id: 'sub1',
      sellerId: 'u2',
      title: 'Wireless Noise Cancelling Earbuds',
      category: 'Gadgets',
      price: 3500.0,
      description: 'Active noise cancellation Bluetooth earbuds with 30h battery life.',
      imageUrl: 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?auto=format&fit=crop&w=600&q=80',
      authorizationInfo: 'Brand authorization cert #GD-102',
      status: AppConstants.statusPending,
    ),
  ];

  // Cart Items
  final List<CartItemModel> cartItems = [];

  // Orders
  final List<OrderModel> orders = [];

  // Chat Messages
  final List<ChatMessageModel> chatMessages = [
    ChatMessageModel(
      id: 'm1',
      senderId: 'u2',
      receiverId: 'u3',
      message: 'Hello Admin, I have submitted a new product with proper details for review.',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    ChatMessageModel(
      id: 'm2',
      senderId: 'u3',
      receiverId: 'u2',
      message: 'Hello Seller, we are verifying your product submission.',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
  ];

  // Notifications
  final List<NotificationModel> notifications = [
    NotificationModel(
      id: 'n1',
      title: 'Welcome to Khan Commerce',
      body: 'Explore all 114 Surahs of the Qur’an, prayer schedule, and verified vendor products.',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  // All 114 Quran Surahs
  List<QuranSurahModel> get quranSurahs => QuranData.allSurahs;

  // Prayer Times
  final PrayerTimeModel prayerTimes = PrayerTimeModel(
    fajr: '04:42 AM',
    dhuhr: '12:05 PM',
    asr: '04:15 PM',
    maghrib: '06:12 PM',
    isha: '07:28 PM',
    date: '14 October 2026',
    location: 'Dhaka, Bangladesh',
  );

  // Authentication methods
  bool login(String email, String password) {
    for (var u in users) {
      if (u.email.toLowerCase() == email.toLowerCase()) {
        currentUser = u;
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  void logout() {
    currentUser = null;
    notifyListeners();
  }

  bool register(String fullName, String mobile, String email, String password, String address, String role) {
    final newUser = UserModel(
      id: 'u_${DateTime.now().millisecondsSinceEpoch}',
      fullName: fullName,
      mobileNumber: mobile,
      email: email,
      currentAddress: address,
      role: role,
    );
    users.add(newUser);
    currentUser = newUser;
    notifyListeners();
    return true;
  }

  // Admin rule violation: remove seller and their listings
  void removeSeller(String sellerId) {
    users.removeWhere((u) => u.id == sellerId);
    submissions.removeWhere((s) => s.sellerId == sellerId);
    products.removeWhere((p) => p.sellerId == sellerId);
    notifyListeners();
  }

  // Cart operations
  void addToCart(ProductModel product) {
    for (var item in cartItems) {
      if (item.product.id == product.id) {
        item.quantity++;
        notifyListeners();
        return;
      }
    }
    cartItems.add(CartItemModel(product: product));
    notifyListeners();
  }

  void removeFromCart(String productId) {
    cartItems.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void clearCart() {
    cartItems.clear();
    notifyListeners();
  }

  double get cartSubtotal {
    double total = 0;
    for (var item in cartItems) {
      total += item.total;
    }
    return total;
  }

  // Order operations
  OrderModel placeOrder({
    required String deliveryAddress,
    required String paymentMethod,
  }) {
    final order = OrderModel(
      id: 'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
      customerId: currentUser?.id ?? 'guest',
      items: List.from(cartItems),
      subtotal: cartSubtotal,
      deliveryCharge: 100.0,
      totalAmount: cartSubtotal + 100.0,
      deliveryAddress: deliveryAddress,
      paymentMethod: paymentMethod,
      paymentStatus: 'Successful',
      orderStatus: AppConstants.orderPending,
      orderDate: DateTime.now(),
    );
    orders.add(order);
    clearCart();
    notifyListeners();
    return order;
  }

  // Seller submission with proper details
  void submitProduct({
    required String title,
    required String category,
    required double price,
    required String description,
    required String imageUrl,
    required String authorizationInfo,
  }) {
    final sub = ListingSubmissionModel(
      id: 'sub_${DateTime.now().millisecondsSinceEpoch}',
      sellerId: currentUser?.id ?? 'u2',
      title: title,
      category: category,
      price: price,
      description: description,
      imageUrl: imageUrl.isEmpty ? 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=600&q=80' : imageUrl,
      authorizationInfo: authorizationInfo,
      status: AppConstants.statusPending,
    );
    submissions.add(sub);
    notifyListeners();
  }

  // Admin approval: only admin can add this product into the app marketplace upon approval
  void updateSubmissionStatus(String subId, String newStatus, {String? adminNotes}) {
    for (var sub in submissions) {
      if (sub.id == subId) {
        sub.status = newStatus;
        sub.adminNotes = adminNotes;
        if (newStatus == AppConstants.statusApproved) {
          // Add to public products marketplace ONLY on admin approval
          final sellerObj = users.firstWhere((u) => u.id == sub.sellerId, orElse: () => UserModel(id: sub.sellerId, fullName: 'Verified Vendor', mobileNumber: '', email: '', currentAddress: '', role: 'Seller'));
          products.add(ProductModel(
            id: 'p_${DateTime.now().millisecondsSinceEpoch}',
            title: sub.title,
            category: sub.category,
            price: sub.price,
            imageUrl: sub.imageUrl,
            description: sub.description,
            sellerId: sub.sellerId,
            sellerName: sellerObj.fullName,
            isApproved: true,
            stockStatus: 'In Stock',
            authorizationInfo: sub.authorizationInfo,
          ));
        }
        notifyListeners();
        break;
      }
    }
  }

  // Chat message sending
  void sendMessage(String receiverId, String text) {
    final msg = ChatMessageModel(
      id: 'm_${DateTime.now().millisecondsSinceEpoch}',
      senderId: currentUser?.id ?? 'u1',
      receiverId: receiverId,
      message: text,
      timestamp: DateTime.now(),
    );
    chatMessages.add(msg);
    notifyListeners();
  }
}
