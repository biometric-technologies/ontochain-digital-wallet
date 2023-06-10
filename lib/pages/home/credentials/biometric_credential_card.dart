import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ontochain_mobile_wallet/model/biometric_credential.dart';

class BiometricCredentialCard extends StatelessWidget {
  final BiometricCredential credential;

  const BiometricCredentialCard({super.key, required this.credential});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          leading: Image.memory(
              base64Decode(credential.credentialSubject.biometrics)),
          title: const Text('Biometric Credential'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5.0),
              Text.rich(
                TextSpan(
                  text: 'Issuer: ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: credential.issuer,
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 3.0),
              Text.rich(
                TextSpan(
                  text: 'Issuance Date: ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: DateFormat.yMMMMEEEEd().format(credential.issuanceDate),
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 3.0),
              Text.rich(
                TextSpan(
                  text: 'Types: ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: credential.type.join(', '),
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
            ],
          ),
          trailing: const Chip(
            label: Text('Verified', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.green,
          )),
    );
  }
}
