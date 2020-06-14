import 'dart:io';

import 'package:Great_Places/helpers/db_helper.dart';
import 'package:flutter/foundation.dart';

import 'package:Great_Places/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace({
    @required String title,
    @required File image,
    double longitude,
    double latitude,
  }) {
    Place newPlace = Place(
      id: DateTime.now().toString(),
      image: image,
      title: title,
      location: PlaceLocation(latitude: latitude, longitude: longitude),
    );

    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'latitude': newPlace.location.latitude,
      'longitude': newPlace.location.longitude,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('places');
    print(dataList);
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
                latitude: item['latitude'], longitude: item['longitude']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
