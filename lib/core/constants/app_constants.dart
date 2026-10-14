class AppConstants {
  static const String appName = 'Khan Commerce Limited';
  
  // Categories
  static const List<String> categories = [
    'Electronics',
    'Mobile Phones & Accessories',
    'Computers & Laptops',
    'Gadgets',
    'Books & Publications',
  ];

  // Payment Methods
  static const List<String> paymentMethods = [
    'bKash',
    'Nagad',
    'Rocket',
    'Bank Transfer',
  ];

  // Listing Statuses
  static const String statusDraft = 'Draft';
  static const String statusPending = 'Pending';
  static const String statusUnderReview = 'Under Review';
  static const String statusApproved = 'Approved';
  static const String statusRejected = 'Rejected';
  static const String statusChangesRequired = 'Changes Required';
  static const String statusResubmitted = 'Resubmitted';

  // Order Statuses
  static const String orderPending = 'Pending';
  static const String orderConfirmed = 'Confirmed';
  static const String orderProcessing = 'Processing';
  static const String orderShipped = 'Shipped';
  static const String orderDelivered = 'Delivered';
  static const String orderCancelled = 'Cancelled';
}
