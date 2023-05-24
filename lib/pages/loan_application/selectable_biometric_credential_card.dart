import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SmallCredentialCard extends StatefulWidget {
  final String id;
  final String photoBase64;
  final String issuer;
  final DateTime issuanceDate;
  final Function(bool) onSelect;

  SmallCredentialCard({
    required this.id,
    required this.photoBase64,
    required this.issuer,
    required this.issuanceDate,
    required this.onSelect,
  });

  @override
  _SmallCredentialCardState createState() => _SmallCredentialCardState();
}

class _SmallCredentialCardState extends State<SmallCredentialCard> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selected = !_selected;
          widget.onSelect(_selected);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: _selected ? Colors.blue : Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Image.memory(base64Decode(widget.photoBase64)),
          title: const Text('Biometric Credential'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Issuer: ${widget.issuer}'),
              Text('Issuance Date: ${DateFormat.yMMMEd().format(widget.issuanceDate)}'),
              /*Text('Types: ${widget.type.join(', ')}'),
              Text('Verified: ${widget.verified ? 'Yes' : 'No'}'),*/
            ],
          ),
        ),
      ),
    );
  }
}
