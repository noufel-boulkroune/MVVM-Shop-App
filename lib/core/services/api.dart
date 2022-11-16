import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mvvp_shop_app/core/models/products.dart';

import '../../utils/constants.dart';

class Api {
  static Api apiInstance = Api();
  bool isLoading = true;

  //get Products

  Future<List<dynamic>?> getProductsData() async {
    try {
      final response = await http.get(Uri.parse(apiLink));
      if (response.statusCode == 200) {
        final responseBody = await jsonDecode(response.body);
        isLoading = false;
        return (responseBody);
      }
    } catch (error) {
      throw error;
    }
  }
}
