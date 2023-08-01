import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontochain_mobile_wallet/shared/drawer/app_drawer_controller.dart';

class DrawerView extends GetView<AppDrawerController> {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Obx(
            () => UserAccountsDrawerHeader(
              accountName: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(controller.name.value),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Row(
                    children: List.generate(
                      controller.rating.value.toInt(),
                      (index) => const Icon(Icons.star,
                          size: 16, color: Colors.yellow),
                    ),
                  ),
                ],
              ),
              accountEmail: Text(controller.email.value),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.indigo,
                child: Text(
                  controller.avatar.value.toUpperCase(),
                  style: const TextStyle(fontSize: 61.0),
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Log Out'),
            leading: const Icon(Icons.logout),
            onTap: controller.logOut,
          ),
        ],
      ),
    );
  }
}
