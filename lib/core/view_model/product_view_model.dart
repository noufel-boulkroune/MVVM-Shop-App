import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/products.dart';
import '../services/api.dart';

class ProductViewModel with ChangeNotifier {
  List<Products> _productsList = [];

  List<Products> get productsList {
    return _productsList;
  }

  Future<void> fetchAndSetData() async {
    List? apiList = await Api.apiInstance.getProductsData();
    _productsList = apiList!
        .map((productElement) => Products.fromJson(productElement))
        .toList();
    notifyListeners();
  }

  void searchFilter(String data) {
    if (_productsList.isEmpty) {
      fetchAndSetData();
    }
    data == null || data == ""
        ? fetchAndSetData()
        : _productsList = _productsList
            .where((productElement) =>
                productElement.title!.toLowerCase().contains(data))
            .toList();
    notifyListeners();
  }
}
