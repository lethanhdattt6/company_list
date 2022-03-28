import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_listcompany/model/company.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_listcompany/Screen/DanhSachCongTy.dart';

class NetWorkRequest {
  static int? page;

  numberPage(int pagenow){
    page = pagenow;
    return page;
  }
  static String url = 'http://192.168.13.103/company/data.php';
  //Function that converts a responese body a List<Company>
  List<Company> parseCompany(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Company>((json) => Company.fromJson(json)).toList();
  }

  Future<List<Company>> fetchCompany() async {
    print(Uri.parse("$url?pageno=$page"));
    final response = await http.get(Uri.parse("$url?pageno=$page"));

    if (response.statusCode == 200) {
      //Use the compute function to run parseCompany in a separate isolate.
      //var body = jsonDecode(response.body);
      //print(body);
      return compute(parseCompany, response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Failed to load Company');
    }
  }

}
