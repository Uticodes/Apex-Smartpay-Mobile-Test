import 'package:apex_smartpay_mobile_test/data/models/smartpay_user.dart';

class RegisterUserResponse {
  bool? status;
  String? message;
  RegisterData? data;
  Map<String, List<String>>? errors;

  RegisterUserResponse({
    this.status,
    this.message,
    this.data,
    this.errors,
  });

  factory RegisterUserResponse.fromJson(Map<String, dynamic> json) {
    return RegisterUserResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: RegisterData.fromJson(json['data']),
      errors: (json['errors'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(key, List<String>.from(value)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
        'errors': errors,
      };
}

class RegisterData {
  RegisterUserData? user;
  String? token;

  RegisterData({
    this.user,
    this.token,
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    return RegisterData(
      user: RegisterUserData.fromJson(json['user']),
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'user': user?.toJson(),
        'token': token,
      };

  @override
  String toString() {
    return 'RegisterUserDat{ token: $token}';
  }
}

class RegisterUserData {
  String? fullName;
  String? userName;
  String? email;
  String? country;
  String? id;

  RegisterUserData({
    this.fullName,
    this.userName,
    this.email,
    this.country,
    this.id,
  });

  factory RegisterUserData.fromJson(Map<String, dynamic> json) {
    return RegisterUserData(
      fullName: json['full_name'] as String?,
      userName: json['username'] as String?,
      email: json['email'] as String?,
      country: json['country'] as String?,
      id: json['id'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'full_name': fullName,
        'userName': userName,
        'email': email,
        'country': country,
        'id': id,
      };

  SmartPayUser get user {
    return SmartPayUser(
      id: id.toString(),
      fullName: fullName.toString(),
      userName: userName.toString(),
      email: email.toString(),
      country: country.toString(),
    );
  }

  @override
  String toString() {
    return 'RegisterUserDat{ full_name: $fullName, userName: $userName, email: $email, country: $country}';
  }
}
