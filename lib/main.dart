import 'package:flutter/material.dart';
import 'package:flutter_notification/routes/route_name.dart';
import 'package:flutter_notification/routes/route_page.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 15, 58, 66)),
          textTheme: GoogleFonts.nunitoTextTheme(
            Theme.of(context).textTheme,
          )),
      initialRoute: AppRouteName.homePage,
      getPages: AppRoutePage().getPage,
    );
  }
}
