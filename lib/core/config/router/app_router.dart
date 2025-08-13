import 'package:flutter/material.dart';
import 'package:tramo_pos/features/product/presentation/list/product_list_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

abstract class AppRoutes {
  AppRoutes._();

  static const products = '/products';
  static const productsNew = '/products/new';
  static const productEdit = '/products/edit';
  static const scan = '/scan';
}

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.products:
        return MaterialPageRoute(builder: (_) => const ProductListPage(), settings: settings);

      case AppRoutes.productsNew:
        return MaterialPageRoute(builder: (_) => const Placeholder(), settings: settings);

      case AppRoutes.productEdit:
        final args = settings.arguments;
        return args! is String
            ? _barArgs('Se esperaba el id del producto.')
            : MaterialPageRoute(builder: (_) => const Placeholder(), settings: settings);
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text('Ruta no encontrada'))),
          settings: settings,
        );
    }
  }

  static Route<dynamic> _barArgs(String message) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(
          child: Column(
            children: [
              Text('Error de navegacion', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 16),
              Text(message),
            ],
          ),
        ),
      ),
    );
  }
}
