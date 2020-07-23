import 'package:Great_Places/providers/great_places.dart';
import 'package:Great_Places/screens/add_place_screen.dart';
import 'package:Great_Places/screens/places_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Places'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
            )
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<GreatPlaces>(
                      child: Center(
                        child: Text('No places yet'),
                      ),
                      builder: (ctx, greatPlaces, ch) =>
                          greatPlaces.items.length <= 0
                              ? ch
                              : ListView.builder(
                                  itemCount: greatPlaces.items.length,
                                  itemBuilder: (ctx, i) => ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          FileImage(greatPlaces.items[i].image),
                                    ),
                                    title: Text(greatPlaces.items[i].title),
                                    subtitle: greatPlaces
                                                .items[i].location.latitude ==
                                            null
                                        ? null
                                        : Text(
                                            '${greatPlaces.items[i].location.latitude}, ${greatPlaces.items[i].location.longitude}'),
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          PlaceDetailScreen.routeName,
                                          arguments: greatPlaces.items[i].id);
                                    },
                                  ),
                                ),
                    ),
        ));
  }
}
