// import 'package:get/get.dart';

// //create a extension named PercentSized for num type
// extension PercentSized on num {
//   double get hp => (Get.height * (this / 100));
//   double get wp => (Get.width * (this / 100));
//   double get sp => Get.width / 100 * (this / 3);
// }

import 'package:flutter/material.dart';

extension PercentSized on num {
  double hp(BuildContext context) =>
      (MediaQuery.of(context).size.height * (this / 100));
  double wp(BuildContext context) =>
      (MediaQuery.of(context).size.width * (this / 100));
  double sp(BuildContext context) =>
      MediaQuery.of(context).size.width / 100 * (this / 3);
}
