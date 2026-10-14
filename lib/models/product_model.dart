class CategoryModel {
  final String id;
  final String name;
  final String imageUrl;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });
}

class ProductModel {
  final String id;
  final String title;
  final String category;
  final double price;
  final String imageUrl;
  final String description;
  final String sellerId;
  final String sellerName;
  final bool isApproved; // Only approved products appear in marketplace
  final String stockStatus; // 'In Stock', 'Out of Stock'
  final String authorizationInfo;

  ProductModel({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.sellerId,
    required this.sellerName,
    required this.isApproved,
    required this.stockStatus,
    required this.authorizationInfo,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'category': category,
        'price': price,
        'imageUrl': imageUrl,
        'description': description,
        'sellerId': sellerId,
        'sellerName': sellerName,
        'isApproved': isApproved,
        'stockStatus': stockStatus,
        'authorizationInfo': authorizationInfo,
      };

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        title: json['title'],
        category: json['category'],
        price: (json['price'] as num).toDouble(),
        imageUrl: json['imageUrl'],
        description: json['description'],
        sellerId: json['sellerId'],
        sellerName: json['sellerName'],
        isApproved: json['isApproved'],
        stockStatus: json['stockStatus'],
        authorizationInfo: json['authorizationInfo'],
      );
}

class ListingSubmissionModel {
  final String id;
  final String sellerId;
  final String title;
  final String category;
  final double price;
  final String description;
  final String imageUrl;
  final String authorizationInfo;
  String status; // 'Draft', 'Pending', 'Under Review', 'Approved', 'Rejected', 'Changes Required'
  String? adminNotes;

  ListingSubmissionModel({
    required this.id,
    required this.sellerId,
    required this.title,
    required this.category,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.authorizationInfo,
    required this.status,
    this.adminNotes,
  });
}
