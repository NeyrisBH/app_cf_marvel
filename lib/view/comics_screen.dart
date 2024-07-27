import 'package:app_cf_marvel/model/comics_model.dart';
import 'package:app_cf_marvel/res/theme/light_color.dart';
import 'package:flutter/material.dart';

class ComicDetailsScreen extends StatelessWidget {
  final ComicModel comic;

  const ComicDetailsScreen({super.key, required this.comic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(comic.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 3 / 4,
              child: Image.network(comic.thumbnail, fit: BoxFit.fill)
            ),
            const SizedBox(height: 16.0),
            Text(
              comic.title,
              style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: LightColor.black),
            ),
            const SizedBox(height: 8.0),
            Text(
              comic.description ?? '',
              style: const TextStyle(fontSize: 16.0, color: LightColor.black),
            ),
          ],
        ),
      ),
    );
  }
}
