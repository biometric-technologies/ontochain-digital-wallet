import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontochain_mobile_wallet/pages/home/applications/applications_tab.dart';
import 'package:ontochain_mobile_wallet/pages/home/credentials/credentials_tab.dart';
import 'package:ontochain_mobile_wallet/pages/home/home_tab_controller.dart';
import 'package:ontochain_mobile_wallet/pages/home/loans/loans_tab.dart';
import 'package:ontochain_mobile_wallet/shared/drawer/app_drawer.dart';
import 'package:ontochain_mobile_wallet/shared/drawer/app_drawer_controller.dart';

class HomeView extends GetView<HomeViewController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loans Mobile Wallet'),
        centerTitle: true,
        bottom: TabBar(
          controller: controller.controller,
          tabs: controller.tabs,
        ),
      ),
      drawer: const DrawerView(),
      onDrawerChanged: (isOpened) {
        if (isOpened) {
          final drawerController = Get.find<AppDrawerController>();
          drawerController.load();
        }
      },
      body: TabBarView(
        controller: controller.controller,
        children: const [
          LoansTab(),
          ApplicationsTab(),
          CredentialsTab(),
        ],
      ),
    );
  }
}
