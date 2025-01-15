import 'package:flutter_notification/controllers/homepage_controller/binding.dart';
import 'package:flutter_notification/pages/homepage/homepage.dart';
import 'package:flutter_notification/routes/route_name.dart';
import 'package:get/route_manager.dart';

class AppRoutePage {
  List<GetPage> getPage = [
    GetPage(
        name: AppRouteName.homePage,
        binding: HomePageBinding(),
        page: () => const HomePage())
  ];
}
