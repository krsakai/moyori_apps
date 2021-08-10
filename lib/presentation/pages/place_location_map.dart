import 'package:flutter/material.dart';
import 'package:moyori/utils/ad_state.dart';
import 'package:moyori/presentation/arguments/place_location_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:moyori/presentation/model/place_location_map.dart';

class PlaceLocationMapPage extends StatelessWidget {

  static Widget provide(PlaceLocationMapPageArguments arguments) => ChangeNotifierProvider<PlaceLocationMapPageModel>(
        create: (BuildContext context) => PlaceLocationMapPageModel(
          currentLocation: arguments.currentLocation,
          targetLocation: arguments.targetLocation,
          name: arguments.name,
        ),
        child: PlaceLocationMapPage(),
  );

  static const routeName = '/home/placeList/placeLocationMap';

  @override
  Widget build(BuildContext context) {
    final PlaceLocationMapPageModel model = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(model.name),
        brightness: Brightness.dark,
      ),
      body: Column(
        children: [
          adMobBanner(context),
          Expanded(
            child: GoogleMap(
              compassEnabled: true,
              mapToolbarEnabled: true,
              onMapCreated: model.onMapCreated,
              markers: model.markers,
              initialCameraPosition: CameraPosition(
                target: model.target,
                zoom: model.zoom,
              ),
              myLocationEnabled: true,
              mapType: MapType.normal,
              minMaxZoomPreference: MinMaxZoomPreference(10, 25)
            ),
          ),
        ]
      ),
    );
  }
}