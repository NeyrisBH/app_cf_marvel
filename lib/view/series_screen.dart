import 'package:app_cf_marvel/model/series_model.dart';
import 'package:app_cf_marvel/res/theme/light_color.dart';
import 'package:flutter/material.dart';

class SeriesScreen extends StatelessWidget {
  final SeriesModel serie;

  const SeriesScreen({super.key, required this.serie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(serie.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 3 / 4,
              child: serie.thumbnailUrl != null
                  ? Image.network(serie.thumbnailUrl!, fit: BoxFit.cover)
                  : Image.asset('assets/images/image_not_available.png',
                      fit: BoxFit.cover),
            ),
            const SizedBox(height: 16.0),
            Text(
              serie.title,
              style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: LightColor.black),
            ),
            const SizedBox(height: 8.0),
            Text(
              serie.description ?? '',
              style: const TextStyle(fontSize: 16.0, color: LightColor.black),
            ),
          ],
        ),
      ),
    );
  }
}
