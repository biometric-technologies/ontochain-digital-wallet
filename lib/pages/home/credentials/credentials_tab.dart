import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'biometric_credential_card.dart';
import 'credentials_tab_controller.dart';

class CredentialsTab extends GetView<CredentialsTabController> {
  const CredentialsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.credentials.isEmpty) {
          return const Center(
            child: Text("You don't have any credentials"),
          );
        } else {
          return ListView.builder(
            itemCount: controller.credentials.length,
            itemBuilder: (context, index) => BiometricCredentialCard(
                credential: controller.credentials[index]),
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.addCredentials,
        child: const Icon(Icons.add),
      ),
    );
  }
}
