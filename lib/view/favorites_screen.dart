import 'package:app_cf_marvel/data/local/favs/database_app.dart';
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

  void _updateRating(double rating) async {
    setState(() {
      rating = rating;
    });
    final db = DatabaseFavApp();
    await db.updateRating(widget.comicId, rating);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Rating: $rating'),
        Slider(
          value: rating,
          min: 0.0,
          max: 5.0,
          divisions: 5,
          label: rating.toString(),
          onChanged: _updateRating,
        ),
      ],
    );
  }
}
