import 'package:app_cf_marvel/model/series_model.dart';
import 'package:app_cf_marvel/res/theme/light_color.dart';
import 'package:app_cf_marvel/view/series_screen.dart';
import 'package:app_cf_marvel/view_model/series/series_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SeriesWidget extends StatefulWidget {
  const SeriesWidget({super.key});

  @override
  SeriesWidgetState createState() => SeriesWidgetState();
}

class SeriesWidgetState extends State<SeriesWidget> {
  final SeriesState seriesState = SeriesState();

  @override
  void initState() {
    super.initState();
    seriesState.fetchSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (seriesState.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: seriesState.seriesCount,
            itemBuilder: (context, index) {
              final series = seriesState.seriesList[index];
              return _buildSeriesCard(series, context);
            },
          );
        }
      },
    );
  }

  Widget _buildSeriesCard(SeriesModel serie, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SeriesScreen(serie: serie),
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
                    child: Image.network(serie.thumbnailUrl, fit: BoxFit.fill)
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      serie.title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: LightColor.black,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      cutDescription(serie.description),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: LightColor.black,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SeriesScreen(serie: serie),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String cutDescription(String? description) {
    if (description != null && description.length > 100) {
      return '${description.substring(0, 100)}...';
    }
    return description ?? '';
  }
}