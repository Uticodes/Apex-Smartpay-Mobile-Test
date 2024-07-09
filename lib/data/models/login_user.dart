import 'package:apex_smartpay_mobile_test/data/models/smartpay_user.dart';

class LoginUserResponse {
  bool? status;
  String? message;
  LoginData? data;
  Map<String, List<String>>? errors;

  LoginUserResponse({this.status, this.message, this.data, this.errors});

  factory LoginUserResponse.fromJson(Map<String, dynamic> json) {
    return LoginUserResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: LoginData.fromJson(json['data']),
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

class LoginData {
  LoginUserData? user;
  String? token;

  LoginData({
    this.user,
    this.token,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      user: LoginUserData.fromJson(json['user']),
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'user': user?.toJson(),
        'token': token,
      };
}

class LoginUserData {
  String? id;
  String? fullName;
  String? userName;
  String? email;
  String? phone;
  String? phoneCountry;
  String? country;
  String? avatar;

  LoginUserData({
    this.id,
    this.fullName,
    this.userName,
    this.email,
    this.phone,
    this.phoneCountry,
    this.country,
    this.avatar,
  });

  factory LoginUserData.fromJson(Map<String, dynamic> json) {
    return LoginUserData(
      id: json['id'] as String?,
      fullName: json['full_name'] as String?,
      userName: json['username'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      phoneCountry: json['phone_country'] as String?,
      country: json['country'] as String?,
      avatar: json['avatar'] as String?,
    );
  }

  SmartPayUser get user {
    return SmartPayUser(
      id: id.toString(),
      fullName: fullName.toString(),
      userName: userName.toString(),
      email: email.toString(),
      phoneNumber: phone.toString(),
      phoneCountry: phoneCountry.toString(),
      country: country.toString(),
      avatar: avatar,

    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'full_name': fullName,
        'username': userName,
        'email': email,
        'phone': phone,
        'phone_country': phoneCountry,
        'country': country,
        'avatar': avatar,
      };
}
