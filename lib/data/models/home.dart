
class HomeResponse {
  bool? status;
  String? message;
  HomeData? data;

  Map<String, List<String>>? errors;

  HomeResponse({
    this.status,
    this.message,
    this.data,
    this.errors,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
        status: json['status'] as bool?,
        message: json['message'] as String?,
        data: HomeData.fromJson(json['data']),
      errors: (json['errors'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, List<String>.from(value)),
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      {'status': status, 'message': message, 'data': data?.toJson(), 'errors': errors};

}

class HomeData {
  String? secret;

  HomeData({
    this.secret,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      secret: json['secret'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'secret': secret,
  };

}