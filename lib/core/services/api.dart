import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/constants.dart';

class Api {
  //get Products

  Future<List<dynamic>?> detProductsData() async {
    try {
      final response = await http.get(Uri.parse(apiLink));
      if (response.statusCode == 200) {
        final responseBody = await jsonDecode(response.body);
        return (responseBody);
      }
    } catch (error) {
      throw error;
    }
  }
}
