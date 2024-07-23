import 'package:app_cf_marvel/model/events_model.dart';
import 'package:app_cf_marvel/res/theme/light_color.dart';
import 'package:flutter/material.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventModel event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 3 / 4,
              child: Image.network(event.thumbnailUrl, fit: BoxFit.fill)
            ),
            const SizedBox(height: 16.0),
            Text(
              event.title,
              style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: LightColor.black),
            ),
            const SizedBox(height: 8.0),
            Text(
              event.description ?? '',
              style: const TextStyle(fontSize: 16.0, color: LightColor.black),
            ),
          ],
        ),
      ),
    );
  }
}
