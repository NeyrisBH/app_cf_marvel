import 'package:app_cf_marvel/main_store/main_state.dart';
import 'package:app_cf_marvel/model/comics_model.dart';
import 'package:app_cf_marvel/res/theme/light_color.dart';
import 'package:app_cf_marvel/view/comics_screen.dart';
import 'package:app_cf_marvel/view_model/comics/comics_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ComicsWidget extends StatefulWidget {
  const ComicsWidget({super.key});

  @override
  ComicsWidgetState createState() => ComicsWidgetState();
}

class ComicsWidgetState extends State<ComicsWidget> {
  late ComicsState comicsState;
  List<ComicModel> favoritesList = [];

  @override
  void initState() {
    super.initState();
    comicsState = ComicsState(main: MainState());
    comicsState.fetchComics();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (comicsState.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: comicsState.comicsCount,
            itemBuilder: (context, index) {
              final comic = comicsState.comicsList[index];
              return _buildComicCard(comic, context);
            },
          );
        }
      },
    );
  }

  Widget _buildComicCard(ComicModel comic, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComicDetailsScreen(comic: comic),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 240,
          height: 260,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: AspectRatio(
                    aspectRatio: 3 / 4,
                    child: Image.network(comic.thumbnail, fit: BoxFit.fill)
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      comic.title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: LightColor.black,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      comic.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: LightColor.black,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ComicDetailsScreen(comic: comic),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: LightColor.lightBlue,
                          ),
                          child: const Text(
                            'Ver Detalles',
                            style: TextStyle(color: LightColor.background),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
