import 'dart:convert';

import 'package:http/http.dart' as http;
class Company {
  final String id;
  final String company_name;
  final String? international_name;
  final String? abbreviations;
  final String ma_so_thue;
  final String company_address;
  final String representative;
  final String? company_phone;
  final String? day_of_operation;
  final String? managed_by;

  const Company({
    required this.id,
    required this.company_name,
    this.international_name,
    this.abbreviations,
    required this.ma_so_thue,
    required this.company_address,
    required this.representative,
    this.company_phone,
    this.day_of_operation,
    this.managed_by,
  });

  factory Company.fromJson(Map<String, dynamic> json){
    String representatives = "";
    if(json['representative']!= null){
      representatives = json['representative'];
    }
    return Company(id: json['id'] as String,
        company_name: json['company_name'] as String,
        international_name: json['international_name'] as String?,
        abbreviations: json['abbreviations'] as String?,
        ma_so_thue: json['ma_so_thue'] as String,
        company_address: json['company_address'] as String,
        representative: representatives,
        company_phone: json['company_phone'] as String?,
        day_of_operation: json['day_of_operation'] as String?,
        managed_by: json['managed_by'] as String?
    );
  }
}
