import 'package:flutter_notification/controllers/homepage_controller/state.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  var state = HomePageState();
  var appBarName = "HomePage";
  bool get isLoading => state.isLoading.value;
  @override
  void onInit() {
    super.onInit();
  }
}
