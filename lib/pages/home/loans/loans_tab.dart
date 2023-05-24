import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loans_tab_controller.dart';

class LoansTab extends GetView<LoansTabController> {
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
              final loan = controller.loans[index];
              return Card(
                child: ListTile(
                  title: Text(loan.id),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Start Date: ${loan.startDate}'),
                      Text('End Date: ${loan.endDate}'),
                      Text('Sum USD: ${loan.sumUSD.toStringAsFixed(2)}'),
                    ],
                  ),
                  trailing: loan.status == 'OPEN' ?
                  Chip(
                    label: Text('Open', style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.green,
                  ):
                  Chip(
                    label: Text('Closed', style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.blue,
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
