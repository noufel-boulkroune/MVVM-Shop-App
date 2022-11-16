import 'package:flutter/material.dart';
import 'package:mvvp_shop_app/core/models/products.dart';
import 'package:provider/provider.dart';

import '../../core/services/api.dart';
import '../../core/view_model/product_view_model.dart';

class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  @override
  void initState() {
    context.read<ProductViewModel>().fetchAndSetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size phoneSize = MediaQuery.of(context).size;

    List<Products> productsList =
        Provider.of<ProductViewModel>(context).productsList;

    return Scaffold(
      appBar: AppBar(
        title: const Text("test"),
      ),
      body: Api.apiInstance.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: "Search",
                      fillColor: Colors.grey.withOpacity(0.5),
                      filled: true,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          borderSide: BorderSide.none),
                    ),

                    //
                    onChanged: (value) {
                      Provider.of<ProductViewModel>(context, listen: false)
                          .searchFilter(value);
                    },

                    onSubmitted: (value) {
                      Provider.of<ProductViewModel>(context, listen: false)
                          .fetchAndSetData();
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ListView.builder(
                      itemCount: productsList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Image.network(
                              productsList[index].image.toString(),
                              height: phoneSize.height * 0.35,
                              width: phoneSize.width * 0.75,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text(productsList[index].title.toString()),
                            ),
                            Divider(),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
