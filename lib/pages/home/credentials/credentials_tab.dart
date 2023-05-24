import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'credentials_tab_controller.dart';

class CredentialsTab extends GetView<CredentialsTabController> {
  CredentialsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: controller.credentials.length,
            itemBuilder: (context, index) {
              var credential = controller.credentials[index];
              return Card(
                child: ListTile(
                  leading: Image.memory(base64Decode(credential.photoBase64)),
                  title: const Text('Biometric Credential'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Issuer: ${credential.issuer}'),
                      Text('Issuance Date: ${DateFormat.yMMMEd().format(credential.issuanceDate)}'),
                      Text('Types: ${credential.type.join(', ')}'),
                    ],
                  ),
                  trailing: Chip(
                    label: Text('Verified', style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.green,
                  )
                ),
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/create_biometrics'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
