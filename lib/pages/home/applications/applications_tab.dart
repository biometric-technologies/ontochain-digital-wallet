import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ontochain_mobile_wallet/pages/home/applications/applications_tab_controller.dart';

class ApplicationsTab extends GetView<ApplicationsTabController> {
  const ApplicationsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: controller.loans.length,
            itemBuilder: (context, index) {
              final application = controller.loans[index];
              return Card(
                child: ListTile(
                  title: Text('Offer: \$1000.0 @ 10%, 30 days'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Start Date: ${DateFormat.yMMMEd().format(DateTime.now())}'),
                      Text(
                          'End Date: ${DateFormat.yMMMEd().format(DateTime.now())}'),
                      Text('Sum USD: ${application.amount.toStringAsFixed(2)}'),
                    ],
                  ),
                  trailing: Chip(
                    label: Text('OPEN', style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.blue,
                  ),
                ),
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/loan_application'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
