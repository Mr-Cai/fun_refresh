import 'package:flutter/material.dart';

class DonationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Image.network(
          'https://pic.downk.cc/item/5e992b50c2a9a83be525fdd1.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
