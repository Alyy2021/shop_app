import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
//  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Settings Screen',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
