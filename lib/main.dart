import 'package:ecomerce_app_two/routes/app_routes.dart';
import 'package:ecomerce_app_two/screens/checkout_screen/checkout.dart';
import 'package:ecomerce_app_two/screens/detailscreen/detail_screen.dart';
import 'package:ecomerce_app_two/screens/main_tab/main_nav_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.spaceGroteskTextTheme(),
      ),
      initialRoute: AppRoutes.homescreen,
      routes: {
        AppRoutes.homescreen: (context) => const MainNavBarScreen(),
        AppRoutes.detailscreen: (context) => const DetailScreen(),
        AppRoutes.checkout: (context) => const Checkout(),
      },
    );
  }

}
