import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:shoppingcart/UI/Products/product_screen.dart';
import 'package:shoppingcart/app/Services/local_storage.dart';
import 'package:shoppingcart/app/constant/assets_const.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  LocalStorageService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
        overlayColor: Colors.white38,
        useDefaultLoading: false,
        overlayWholeScreen: true,
        overlayWidgetBuilder: (_) {
          return PopScope(
            canPop: false,
            child: Center(
              child: Lottie.asset(
                AppAssets.lottie,
                height: 120,
                width: 120,
                animate: true,
              ),
            ),
          );
        },
        child: MaterialApp(
          title: 'Shopping Cart',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const ProductScreen(),
        ));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
