import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/products.dart';
import '../services/api.dart';

class ProductViewModel with ChangeNotifier {
  final Set<String> _categories = {"All"};
  List<String> _categoriesList = [];
  List<Products> _productsList = [];

  List<Products> get productsList {
    return _productsList;
  }

  List<String> get categories {
    return _categoriesList;
  }

  Future<void> fetchAndSetData() async {
    List? apiList = await Api.apiInstance.getProductsData();
    _productsList = apiList!
        .map((productElement) => Products.fromJson(productElement))
        .toList();

    _productsList.forEach((e) => _categories.add(e.category!));
    _categoriesList = _categories.toList();
    print(_categoriesList);

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

  void updateByCategory(String category) {
    if (category == "All") {
      fetchAndSetData();
    } else {
      fetchAndSetData().then((value) => _productsList = _productsList
          .where((productElement) => productElement.category == category)
          .toList());

      notifyListeners();
    }
  }
}
