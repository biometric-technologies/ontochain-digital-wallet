import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/loan_offer.dart';
import 'loan_application_controller.dart';
import 'selectable_biometric_credential_card.dart';

class LoanApplicationView extends GetView<LoanApplicationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Apply for a Loan')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
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
                      child: Text(value.name),
                    );
                  }).toList(),
                  hint: Text('Select Offer'),
                  isExpanded: true,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (value) => controller.firstName.value = value,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (value) => controller.lastName.value = value,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (value) =>
                    controller.age.value = int.tryParse(value)!,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (value) => controller.phone.value = value,
                decoration: InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (value) => controller.email.value = value,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              Center(
                  child: Text('Select Credentials to Submit',
                      style: Theme.of(context).textTheme.titleMedium)),
              const SizedBox(height: 16),
              Obx(
                () => Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: controller.credentials
                      .map((credential) => SmallCredentialCard(
                            id: 'credential.id',
                            photoBase64: credential.photoBase64,
                            issuer: credential.issuer,
                            issuanceDate: credential.issuanceDate,
                            onSelect: (selected) {
                            },
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  // Here you can handle the loan application submission.
                },
                child: Text('Submit Application'),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
