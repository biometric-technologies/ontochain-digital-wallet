import 'dart:convert';

import 'package:flutter/material.dart';

class BiometricCredentialCard extends StatelessWidget {
  final String image;
  final String issuer;
  final DateTime issuanceDate;

  const BiometricCredentialCard(
      {super.key,
      required this.image,
      required this.issuer,
      required this.issuanceDate});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Image.memory(base64Decode(image)),
            Text('Issuer: $issuer'),
            Text('Issuance Date: ${issuanceDate.toIso8601String()}'),
          ],
        ),
      ),
    );
  }
}
