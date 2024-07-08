class VerifyEmailTokenResponse {
  bool? status;
  String? message;
  VerifyEmailTokenData? data;
  Map<String, List<String>>? errors;

  VerifyEmailTokenResponse({
    this.status,
    this.message,
    this.data,
    this.errors
  });

  VerifyEmailTokenResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data =
    json['data'] != null ? VerifyEmailTokenData.fromJson(json['data']) : null;
    errors = (json['errors'] as Map<String, dynamic>?)?.map(
          (key, value) => MapEntry(key, List<String>.from(value)),
    );
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['errors'] = errors;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

  @override
  String toString() {
    return 'VerifyEmailTokenResponse{status: $status, message: $message, errors: $errors}';
  }

}

class VerifyEmailTokenData {
  String? email;

  VerifyEmailTokenData({
    this.email,
  });

  VerifyEmailTokenData.fromJson(dynamic json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['email'] = email;
    return map;
  }

  @override
  String toString() {
    return 'VerifyEmailToken{email: $email}';
  }

}