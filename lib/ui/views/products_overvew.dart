import 'dart:ui';

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
    List<String> categories = Provider.of<ProductViewModel>(context).categories;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "test",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.read<ProductViewModel>().fetchAndSetData();
              },
              icon: Icon(Icons.add))
        ],
      ),
      drawer: Drawer(),
      body: Api.apiInstance.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: "Search",
                      fillColor: Colors.orange.withOpacity(0.5),
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
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: phoneSize.height * 0.06,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: Card(
                              color: Theme.of(context).primaryColor,
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Center(
                                  child: Text(
                                    categories[index].toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )),
                          onTap: () {
                            Provider.of<ProductViewModel>(context,
                                    listen: false)
                                .updateByCategory(categories[index]);
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
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
                  )
                ],
              ),
            ),
    );
  }
}
