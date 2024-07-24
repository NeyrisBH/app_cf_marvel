import 'package:app_cf_marvel/data/local/favs/database_app.dart';
import 'package:app_cf_marvel/view/favorites_screen.dart';
import 'package:flutter/material.dart';

class FavoritesWidget extends StatefulWidget {
  final int comicId;

  const FavoritesWidget({super.key, required this.comicId});

  @override
  FavoritesWidgetState createState() => FavoritesWidgetState();
}

class FavoritesWidgetState extends State<FavoritesWidget> {
  late Future<Map<String, dynamic>> _comic;

  @override
  void initState() {
    super.initState();
    _comic = _fetchComic();
  }

  Future<Map<String, dynamic>> _fetchComic() async {
    final db = DatabaseFavApp();
    final List<Map<String, dynamic>> result = await db.getComics();
    return result.firstWhere((comic) => comic['id'] == widget.comicId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _comic,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: const Text('Comic Details')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Comic Details')),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        final comic = snapshot.data!;
        return Scaffold(
          appBar: AppBar(title: Text(comic['title'])),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(comic['description']),
                const SizedBox(height: 16.0),
                FavoritesScreen(
                  comicId: widget.comicId,
                  initialRating: comic['rating'],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
