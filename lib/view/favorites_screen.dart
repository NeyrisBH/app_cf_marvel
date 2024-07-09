import 'package:app_cf_marvel/data/local/database_app.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseApp().getFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay cómics favoritos'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final favorite = snapshot.data![index];
                return ListTile(
                  title: Text(favorite['title']),
                  subtitle: Text(favorite['description']),
                  leading: Image.network(favorite['thumbnailUrl']),
                );
              },
            );
          }
        },
      ),
    );
  }
}
