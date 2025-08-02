import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/core/helper_functions/on_generate_routes.dart';
import 'package:fruts_e_commerce/features/splash/presentation/views/splash_view.dart';

void main() {
  runApp(const FrutHub());
}
class FrutHub extends StatelessWidget {
  const FrutHub
({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: onGenerateRoute,
      initialRoute: SplashView.routeName, 
      debugShowCheckedModeBanner: false,
    );
  }
}