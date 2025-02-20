import 'package:flutter/material.dart';
import 'package:flutter_notification/controllers/homepage_controller/controller.dart';
import 'package:flutter_notification/responsive/responsive.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          controller.appBarName,
          style: TextStyle(
              color: Colors.white,
              // fontSize: 12.sp,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
