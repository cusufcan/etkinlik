import 'package:etkinlik/base/constant/app_string.dart';
import 'package:flutter/material.dart';
import 'package:map_location_picker/map_location_picker.dart';

part 'location_pick_view_model.dart';

class LocationPickView extends StatefulWidget {
  const LocationPickView({
    super.key,
    required this.onLocationPicked,
    required this.currentLatLng,
  });

  final void Function(GeocodingResult? address) onLocationPicked;
  final LatLng currentLatLng;

  @override
  State<LocationPickView> createState() => _LocationPickViewState();
}

class _LocationPickViewState extends _LocationPickViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konum Seç'),
      ),
      body: GoogleMapLocationPicker(
        apiKey: _appString.MAPS_API_KEY,
        onNext: (result) {
          widget.onLocationPicked(result);
          Navigator.of(context).pop();
        },
        language: 'tr',
        currentLatLng: widget.currentLatLng,
        searchHintText: 'Ara',
        hideLocationButton: true,
      ),
    );
  }
}
