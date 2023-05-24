import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontochain_mobile_wallet/pages/home/applications/applications_tab.dart';
import 'package:ontochain_mobile_wallet/pages/home/credentials/credentials_tab.dart';
import 'package:ontochain_mobile_wallet/pages/home/home_tab_controller.dart';
import 'package:ontochain_mobile_wallet/pages/home/loans/loans_tab.dart';

class HomeView extends GetView<HomeTabController> {
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('CREDIT WALLET',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                // Navigate to Profile
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller.controller,
        children: [
          LoansTab(),
          ApplicationsTab(),
          CredentialsTab(),
        ],
      ),
    );
  }
}
