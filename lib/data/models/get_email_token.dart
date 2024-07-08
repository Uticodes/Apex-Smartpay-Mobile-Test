
class GetEmailTokenResponse {
  bool? status;
  String? message;
  GetEmailTokenData? data;
  Map<String, List<String>>? errors;

  GetEmailTokenResponse({
    this.status,
    this.message,
    this.data,
    this.errors,
  });

  GetEmailTokenResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? GetEmailTokenData.fromJson(json['data']) : null;
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
    return 'GetEmailTokenResponse{status: $status, message: $message, errors: $errors}';
  }

}

class GetEmailTokenData {
  String? token;

  GetEmailTokenData({
    this.token,
  });

  GetEmailTokenData.fromJson(dynamic json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['token'] = token;
    return map;
  }

  @override
  String toString() {
    return 'GetEmailTokenResponse{token: $token}';
  }

}