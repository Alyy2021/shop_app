import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
//  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Favorites Screen',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
