import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    const Tab(text: 'Loans'),
    const Tab(text: 'Applications'),
    const Tab(text: 'Credentials'),
  ];

  late TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: tabs.length);
  }

  @override
  void onClose() {
    super.onClose();
    controller.dispose();
  }
}
