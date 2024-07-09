import 'package:app_cf_marvel/res/theme/light_color.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  FavoritesScreenState createState() => FavoritesScreenState();
}

class FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Favoritos',
        style: TextStyle(color: LightColor.black),
      ),
    );
  }
}
