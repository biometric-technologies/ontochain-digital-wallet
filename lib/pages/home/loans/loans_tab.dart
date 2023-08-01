import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ontochain_mobile_wallet/model/loan.dart';

import 'loans_tab_controller.dart';

class LoansTab extends GetView<LoansTabController> {
  const LoansTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: controller.load,
        child: Obx(
          () {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  if (controller.loans.isEmpty)
                    const SliverFillRemaining(
                      child: Center(
                        child: Text('You don\'t have any loans'),
                      ),
                    )
                  else
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) =>
                            LoanRow(loan: controller.loans[index]),
                        childCount: controller.loans.length,
                      ),
                    ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class LoanRow extends StatelessWidget {
  final Loan loan;

  const LoanRow({super.key, required this.loan});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(loan.id),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: 'Start Date: ',
                style: const TextStyle(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: DateFormat.yMMMMEEEEd().format(loan.startDate),
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  )
                ],
              ),
            ),
            const SizedBox(height: 2.0),
            Text.rich(
              TextSpan(
                text: 'End Date: ',
                style: const TextStyle(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: DateFormat.yMMMMEEEEd().format(loan.endDate),
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
                    text: '\$${loan.amount.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  )
                ],
              ),
            ),
          ],
        ),
        trailing: LoanStatusWidget(isOpen: loan.open),
      ),
    );
  }
}

class LoanStatusWidget extends StatelessWidget {
  final bool isOpen;

  const LoanStatusWidget({super.key, required this.isOpen});

  @override
  Widget build(BuildContext context) {
    if (isOpen) {
      return const Chip(
        label: Text('Open', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      );
    } else {
      return const Chip(
        label: Text('Closed', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      );
    }
  }
}
