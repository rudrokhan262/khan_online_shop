import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/mock_database_service.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_routes.dart';

import 'features/auth/login_screen.dart';
import 'features/auth/registration_screen.dart';
import 'features/home/home_screen.dart';
import 'features/home/search_screen.dart';
import 'features/home/categories_screen.dart';
import 'features/products/product_details_screen.dart';
import 'features/cart/cart_screen.dart';
import 'features/cart/checkout_screen.dart';
import 'features/cart/order_confirmation_screen.dart';
import 'features/orders/order_history_screen.dart';
import 'features/orders/order_tracking_screen.dart';
import 'features/seller/seller_dashboard_screen.dart';
import 'features/seller/submit_product_screen.dart';
import 'features/seller/listing_status_screen.dart';
import 'features/admin/admin_dashboard_screen.dart';
import 'features/admin/admin_listing_review_screen.dart';
import 'features/admin/admin_user_management_screen.dart';
import 'features/chat/chat_conversation_list_screen.dart';
import 'features/chat/chat_screen.dart';
import 'features/account/account_screen.dart';
import 'features/account/notifications_screen.dart';
import 'features/account/help_support_screen.dart';
import 'features/account/policies_screen.dart';
import 'features/quran/quran_screen.dart';
import 'features/prayer/prayer_schedule_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MockDatabaseService()),
      ],
      child: const KhanCommerceApp(),
    ),
  );
}

class KhanCommerceApp extends StatelessWidget {
  const KhanCommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Khan Commerce Limited',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.registration: (context) => const RegistrationScreen(),
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.search: (context) => const SearchScreen(),
        AppRoutes.categories: (context) => const CategoriesScreen(),
        AppRoutes.productDetails: (context) => const ProductDetailsScreen(),
        AppRoutes.cart: (context) => const CartScreen(),
        AppRoutes.checkout: (context) => const CheckoutScreen(),
        AppRoutes.orderConfirmation: (context) => const OrderConfirmationScreen(),
        AppRoutes.orderHistory: (context) => const OrderHistoryScreen(),
        AppRoutes.orderTracking: (context) => const OrderTrackingScreen(),
        AppRoutes.sellerDashboard: (context) => const SellerDashboardScreen(),
        AppRoutes.submitProduct: (context) => const SubmitProductScreen(),
        AppRoutes.listingStatus: (context) => const ListingStatusScreen(),
        AppRoutes.adminDashboard: (context) => const AdminDashboardScreen(),
        AppRoutes.adminListingReview: (context) => const AdminListingReviewScreen(),
        AppRoutes.adminUserManagement: (context) => const AdminUserManagementScreen(),
        AppRoutes.chatConversationList: (context) => const ChatConversationListScreen(),
        AppRoutes.chat: (context) => const ChatScreen(),
        AppRoutes.account: (context) => const AccountScreen(),
        AppRoutes.notifications: (context) => const NotificationsScreen(),
        AppRoutes.helpSupport: (context) => const HelpSupportScreen(),
        AppRoutes.policies: (context) => const PoliciesScreen(),
        AppRoutes.quran: (context) => const QuranScreen(),
        AppRoutes.prayer: (context) => const PrayerScheduleScreen(),
      },
    );
  }
}
