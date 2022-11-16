import 'package:flutter/material.dart';
import 'package:mvvp_shop_app/ui/views/products_overvew.dart';
import 'package:provider/provider.dart';

import 'core/view_model/product_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductViewModel(),
      child: MaterialApp(
        title: 'MVVP Shop app',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: test(),
      ),
    );
  }
}
