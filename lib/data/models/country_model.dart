
import 'dart:convert';
import 'package:flutter/services.dart';

class CountryModel {
  final String name;
  final String flag;
  final String code;
  final String dialCode;

  CountryModel({
    required this.name,
    required this.flag,
    required this.code,
    required this.dialCode,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name'] as String,
      flag: json['flag'] as String,
      code: json['code'] as String,
      dialCode: json['dial_code'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'flag': flag,
      'code': code,
      'dial_code': dialCode,
    };
  }
}

List<CountryModel> parseCountries(List<dynamic> jsonList) {
  return jsonList.map((json) => CountryModel.fromJson(json)).toList();
}

Future<List<CountryModel>> loadCountries() async {
  final String response =
  await rootBundle.loadString('assets/json/country_codes.json');
  final List<dynamic> data = json.decode(response);
  return data.map((json) => CountryModel.fromJson(json)).toList();
}