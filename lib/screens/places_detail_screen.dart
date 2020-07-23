import 'package:Great_Places/helpers/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';

  String _getImageUrl(double lat, double lon) {
    return LocationHelper.generateLocationImageLarge(
        latitude: lat, longitude: lon);
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<GreatPlaces>(context, listen: false).findById(id);
    final mapUrl = _getImageUrl(
        selectedPlace.location.latitude, selectedPlace.location.longitude);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Latitude: ${selectedPlace.location.latitude}, Longitude: ${selectedPlace.location.longitude}',
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: MediaQuery.of(context).size.width,
            width: double.infinity,
            alignment: Alignment.center,
            child: Image.network(
              mapUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          )
        ],
      ),
    );
  }
}
