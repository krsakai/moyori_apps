import 'dart:math';

import 'package:moyori/utils/ad_state.dart';
import 'package:moyori/domain/entities/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import 'package:moyori/presentation/arguments/place_list.dart';
import 'package:moyori/presentation/arguments/place_location_map.dart';
import 'package:moyori/presentation/model/place_list.dart';
import 'package:moyori/presentation/pages/place_location_map.dart';
import 'package:moyori/utils/loading.dart';

class PlaceListPage extends StatelessWidget {
  const PlaceListPage() : super();

  static const routeName = '/home/placeList';

  static Widget provide(PlaceListPageArguments arguments) => ChangeNotifierProvider<PlaceListPageModel>(
    create: (BuildContext context) => PlaceListPageModel(
      placeRepository: Provider.of(context, listen: false),
      lat: arguments.lat,
      lon: arguments.lon,
      searchWord: arguments.searchWord,
      placeType: arguments.placeType
    )..initialize(),
    child: const PlaceListPage()
  );

  @override
  Widget build(BuildContext context) {
    final PlaceListPageModel model = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('近場の' + model.searchWord + '一覧'),
        brightness: Brightness.dark,
      ),
      body: Stack(children: [
        Column(
          children: [
            adMobBanner(context),
            Expanded(
              child: model.placeList.isEmpty ? _errorSection : _placeListSection,
            )
          ],
        ),
        model.isLoading ? LoadingWidget : Container()
      ],)
    );
  }

  Widget get _errorSection => Consumer<PlaceListPageModel>(builder: (context, model, _) {
    final PlaceListPageModel model = Provider.of(context);
    return Container(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 0, bottom: 0),
        child: Text(
          model.isNetworkError ? "通信に失敗しました\n電波の良い所で再度検索して下さい" : "検索結果がありません", 
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      )
    );
  });

  Widget get _placeListSection => Consumer<PlaceListPageModel>(builder: (context, model, _) {
    return ListView.builder(
      itemCount: model.placeList.length,
      itemBuilder: (BuildContext context, int index) {
        return PictureCard(model.placeList[index]);
      },
    );
  });
}

class PictureCard extends StatelessWidget {

  final Place place;

  PictureCard(this.place);

  @override
  Widget build(BuildContext context) {
    final PlaceListPageModel model = Provider.of(context);
    return Card(
      child: InkWell(
        onTap: () async {
          await Navigator.pushNamed<void>(
            context, 
            PlaceLocationMapPage.routeName,
            arguments: PlaceLocationMapPageArguments(
              currentLocation: Point(model.lat,model.lon),
              targetLocation: Point(place.lat, place.lon),
              name: place.name,
              ),
            );
        },
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black45),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ListTile(
                leading: Image.network(place.iconUrl),
                title: Text(place.name),
                subtitle: Text(place.vicinity),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: place.photoUrl != null ? 
                  CachedNetworkImage(
                    imageUrl: place.photoUrl! + const String.fromEnvironment("GOOGLE_API_KEY"),
                    placeholder: (_, url) => CupertinoActivityIndicator(radius: 20),
                    errorWidget: (_, url, error) => Icon(Icons.no_photography , color: Colors.grey, size: 100.0),
                  ) : Icon(Icons.no_photography , color: Colors.grey, size: 100.0)
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [ 
                    Text("距離"),
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text((place.distance(model.lat, model.lon)).toStringAsFixed(2) + "m")
                    )
                  ]),
                  Row(children: [ 
                    Text("★"),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text((place.rating ?? 0).toString())
                    )
                  ]) 
                ])
            ],
          ),
        ),
      ),
    );
  }
}
