import 'package:app_cf_marvel/main_store/main_state.dart';
import 'package:app_cf_marvel/model/events_model.dart';
import 'package:app_cf_marvel/res/theme/light_color.dart';
import 'package:app_cf_marvel/view/events_screen.dart';
import 'package:app_cf_marvel/view_model/events/events_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class EventsWidget extends StatefulWidget {
  const EventsWidget({super.key});

  @override
  EventsWidgetState createState() => EventsWidgetState();
}

class EventsWidgetState extends State<EventsWidget> {
  late EventsState eventsState;
  List<EventModel> favoritesList = [];

  @override
  void initState() {
    super.initState();
    eventsState = EventsState(main: MainState());
    eventsState.fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (eventsState.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: eventsState.eventsCount,
            itemBuilder: (context, index) {
              final event = eventsState.eventsList[index];
              return _buildEventCard(event, context);
            },
          );
        }
      },
    );
  }

  Widget _buildEventCard(EventModel event, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsScreen(event: event),
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
                    child: Image.network(event.thumbnailUrl, fit: BoxFit.fill)
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      event.title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: LightColor.black,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      cutDescription(event.description),
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
                                    EventDetailsScreen(event: event),
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

  String cutDescription(String? description) {
    if (description != null && description.length > 100) {
      return '${description.substring(0, 100)}...';
    }
    return description ?? '';
  }
}
