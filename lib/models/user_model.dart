class UserModel {
  final String id;
  final String fullName;
  final String mobileNumber;
  final String email;
  final String currentAddress;
  final String role; // 'Customer', 'Seller', 'Administrator'

  UserModel({
    required this.id,
    required this.fullName,
    required this.mobileNumber,
    required this.email,
    required this.currentAddress,
    required this.role,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'mobileNumber': mobileNumber,
        'email': email,
        'currentAddress': currentAddress,
        'role': role,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        fullName: json['fullName'],
        mobileNumber: json['mobileNumber'],
        email: json['email'],
        currentAddress: json['currentAddress'],
        role: json['role'],
      );
}

class AddressModel {
  final String id;
  final String title;
  final String fullAddress;
  final String phone;

  AddressModel({
    required this.id,
    required this.title,
    required this.fullAddress,
    required this.phone,
  });
}
