import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ontochain_mobile_wallet/model/loan_application.dart';
import 'package:ontochain_mobile_wallet/pages/home/applications/applications_tab_controller.dart';

class ApplicationsTab extends GetView<ApplicationsTabController> {
  const ApplicationsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: controller.load,
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                if (controller.applications.isEmpty)
                  const SliverFillRemaining(
                    child:
                        Center(child: Text('You don\'t have any applications')),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => ApplicationRow(
                          application: controller.applications[index]),
                      childCount: controller.applications.length,
                    ),
                  ),
              ],
            );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.newApplication,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ApplicationRow extends GetView<ApplicationsTabController> {
  final LoanApplication application;

  const ApplicationRow({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(controller.getOfferName(application.offerId)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5.0),
            Text.rich(
              TextSpan(
                text: 'Created Date: ',
                style: const TextStyle(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: DateFormat.yMMMMEEEEd().format(application.createdAt),
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  )
                ],
              ),
            ),
            const SizedBox(height: 2.0),
            Text.rich(
              TextSpan(
                text: 'Sum: ',
                style: const TextStyle(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: "\$${application.amount.toStringAsFixed(2)}",
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  )
                ],
              ),
            ),
            if (application.deniedReason != null)
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text.rich(
                  TextSpan(
                    text: 'Denied reason: ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: application.deniedReason,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ),
              )
            else
              const SizedBox()
          ],
        ),
        trailing: ApplicationStatusWidget(status: application.status),
      ),
    );
  }
}

class ApplicationStatusWidget extends StatelessWidget {
  final LoanApplicationStatus status;

  const ApplicationStatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case LoanApplicationStatus.open:
        return const Chip(
          label: Text('Open', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.green,
        );
      case LoanApplicationStatus.approved:
        return const Chip(
          label: Text('Approved', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
        );
      case LoanApplicationStatus.denied:
        return const Chip(
          label: Text('Denied', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
        );
    }
  }
}
