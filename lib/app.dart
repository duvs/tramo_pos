import 'package:flutter/material.dart';
import 'package:tramo_pos/core/config/theme/app_theme.dart';
import 'package:tramo_pos/features/product/presentation/list/product_list_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', theme: appTheme, home: ProductListPage());
  }
}
