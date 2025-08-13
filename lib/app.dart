import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tramo_pos/core/config/router/app_router.dart';
import 'package:tramo_pos/core/config/theme/app_theme.dart';
import 'package:tramo_pos/features/product/presentation/list/product_list_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tramo POS',
      locale: const Locale('es', 'NI'),
      supportedLocales: const [Locale('es', 'NI'), Locale('es')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: appTheme,
      navigatorKey: navigatorKey,
      initialRoute: AppRoutes.products,
      onGenerateRoute: AppRouter.onGenerateRoute,
      home: ProductListPage(),
    );
  }
}
