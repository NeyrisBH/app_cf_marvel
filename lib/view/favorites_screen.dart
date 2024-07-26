import 'package:app_cf_marvel/res/theme/light_color.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  final int comicId;
  final double initialRating;
  const FavoritesScreen(
      {super.key, required this.comicId, required this.initialRating});

  @override
  FavoritesScreenState createState() => FavoritesScreenState();
}

class FavoritesScreenState extends State<FavoritesScreen> {
  late double rating;

  @override
  void initState() {
    super.initState();
    rating = widget.initialRating;
  }
  
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Aún no has escogido comics favoritos',
        style: TextStyle(
          color: LightColor.black,
        ),
      ),
    );
  }
}
