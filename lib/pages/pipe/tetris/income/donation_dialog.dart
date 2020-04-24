import 'package:flutter/material.dart';
import 'package:fun_refresh/tools/global.dart';

class DonationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeW(context) * .5,
      height: sizeH(context) * .5,
      child: Image.network(
        'https://pic.downk.cc/item/5e992b50c2a9a83be525fdd1.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
