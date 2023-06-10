import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ontochain_mobile_wallet/model/biometric_credential.dart';

class SmallCredentialCard extends StatelessWidget {
  final BiometricCredential credential;
  final bool isSelected;
  final Function(BiometricCredential) onChanged;

  const SmallCredentialCard({
    super.key,
    required this.credential,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(credential),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
            color: isSelected ? Colors.white.withOpacity(0.5) : Colors.white,
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.transparent,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(5.0)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(8.0),
          leading: Image.memory(
              base64Decode(credential.credentialSubject.biometrics)),
          title: const Text('Biometric Credential'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Issuer: ${credential.issuer}'),
              Text(
                  'Issuance Date: ${DateFormat.yMMMEd().format(credential.issuanceDate)}'),
            ],
          ),
        ),
      ),
    );
  }
}
