import 'package:flutter/material.dart';
import 'package:mvvp_shop_app/core/models/products.dart';
import 'package:provider/provider.dart';

import '../core/view_model/product_view_model.dart';

class test extends StatelessWidget {
  const test({super.key});

  @override
  Widget build(BuildContext context) {
    List<Products> productsList =
        Provider.of<ProductViewModel>(context).productsList;
    return Scaffold(
      appBar: AppBar(
        title: Text("test"),
        actions: [
          IconButton(
              onPressed: () {
                context.read<ProductViewModel>().fetchAndSetData();
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: productsList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: productsList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(productsList[index].title!),
                );
              },
            ),
    );
  }
}
