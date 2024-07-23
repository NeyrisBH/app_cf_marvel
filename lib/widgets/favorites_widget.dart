import 'package:app_cf_marvel/data/local/database_app.dart';
import 'package:flutter/material.dart';

class FavoritesWidget extends StatefulWidget {
  final int comicId;
  final double initialRating;

  const FavoritesWidget({super.key, required this.comicId, required this.initialRating});

  @override
  FavoritesWidgetState createState() => FavoritesWidgetState();
}

class FavoritesWidgetState extends State<FavoritesWidget> {
  late double _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  void _updateRating(double rating) async {
    setState(() {
      _rating = rating;
    });
    final db = DatabaseApp();
    await db.updateRating(widget.comicId, rating);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Rating: $_rating'),
        Slider(
          value: _rating,
          min: 0.0,
          max: 5.0,
          divisions: 5,
          label: _rating.toString(),
          onChanged: _updateRating,
        ),
      ],
    );
  }
}
