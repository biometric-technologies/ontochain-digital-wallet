import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontochain_mobile_wallet/model/loan_offer.dart';

import 'loan_application_controller.dart';
import 'selectable_biometric_credential_card.dart';

class LoanApplicationView extends GetView<LoanApplicationController> {
  const LoanApplicationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Apply for a Loan')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 30),
              Obx(
                () => DropdownButton<LoanOffer>(
                  value: controller.selectedOffer.value,
                  onChanged: (newValue) =>
                      controller.selectedOffer.value = newValue,
                  items: controller.offers
                      .map<DropdownMenuItem<LoanOffer>>((LoanOffer value) {
                    return DropdownMenuItem<LoanOffer>(
                      value: value,
                      child: Text(
                          '${value.name} \$${value.amount} (${value.days} days)'),
                    );
                  }).toList(),
                  hint: const Text('Select Offer'),
                  isExpanded: true,
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => TextField(
                  controller: TextEditingController(
                    text: controller.firstName.value,
                  ),
                  onChanged: (value) => controller.firstName.value = value,
                  decoration: const InputDecoration(labelText: 'First Name'),
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => TextField(
                  controller: TextEditingController(
                    text: controller.lastName.value,
                  ),
                  onChanged: (value) => controller.lastName.value = value,
                  decoration: const InputDecoration(labelText: 'Last Name'),
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => TextField(
                  controller: TextEditingController(
                    text: controller.age.value.toString(),
                  ),
                  onChanged: (value) => controller.age.value = value,
                  decoration: const InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => TextField(
                  controller: TextEditingController(
                    text: controller.phone.value,
                  ),
                  onChanged: (value) => controller.phone.value = value,
                  decoration: const InputDecoration(labelText: 'Phone'),
                  keyboardType: TextInputType.phone,
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => TextField(
                  controller: TextEditingController(
                    text: controller.email.value,
                  ),
                  onChanged: (value) => controller.email.value = value,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                  child: Text('Select Credentials to Submit',
                      style: Theme.of(context).textTheme.titleMedium)),
              const SizedBox(height: 16),
              ObxValue(
                  (data) => Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: controller.credentials
                            .map(
                              (credential) => SmallCredentialCard(
                                credential: credential,
                                isSelected:
                                    controller.isCredentialSelected(credential),
                                onChanged: (credential) {
                                  if (data.contains(credential)) {
                                    data.remove(credential);
                                  } else {
                                    data.add(credential);
                                  }
                                },
                              ),
                            )
                            .toList(),
                      ),
                  controller.selectedCredentials),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: controller.submit,
                child: const Text('Submit Application'),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
