import 'package:flutter/material.dart';
import 'package:moyori/app_model.dart';
import 'package:moyori/domain/repositories/place.dart';
import 'package:moyori/infrastructure/web/core/service.dart';
import 'package:moyori/infrastructure/repositories/place.dart';
import 'package:moyori/presentation/arguments/place_list.dart';
import 'package:moyori/presentation/arguments/place_location_map.dart';
import 'package:moyori/presentation/pages/home.dart';
import 'package:moyori/presentation/pages/place_list.dart';
import 'package:moyori/presentation/pages/place_location_map.dart';
import 'package:moyori/presentation/pages/splash.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:moyori/utils/color.dart';
import 'package:moyori/utils/device_info.dart';
import 'package:flutter/services.dart';

class Application extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MultiProvider(
        providers: <SingleChildWidget>[
          Provider<WebService>(
            create: (BuildContext context) => WebServiceImpl(),
          ),
          Provider<PlaceRepository>(
            create: (BuildContext context) => PlaceRepositoryImpl(
              webService: Provider.of(context, listen: false),
            ),
          ),
          Provider<NetworkStatus>(
            create: (BuildContext context) => NetworkStatus()..init()
          ),
          Provider<AppModel>(
            create: (BuildContext context) => AppModel(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: AppColor.customSwatch,
          ),
          initialRoute: '/',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case Splash.routeName:
                return MaterialPageRoute<void>(
                  builder: (context) => Splash.provide(),
                  settings: settings,
              );
              case HomePage.routeName:
                return MaterialPageRoute<void>(
                  builder: (context) => HomePage.provide(),
                  settings: settings,
              );
              case PlaceListPage.routeName:
                final PlaceListPageArguments arguments = settings.arguments as PlaceListPageArguments;
                return MaterialPageRoute<void>(
                  builder: (context) => PlaceListPage.provide(arguments),
                  settings: settings,
              );
              case PlaceLocationMapPage.routeName:
                final PlaceLocationMapPageArguments arguments = settings.arguments as PlaceLocationMapPageArguments;
                return MaterialPageRoute<void>(
                  builder: (context) => PlaceLocationMapPage.provide(arguments),
                  settings: settings,
              );
                default:
                return MaterialPageRoute<void>(
                  builder: (context) => HomePage(),
                  settings: settings,
              );
            }
          },
        )
    );
  }
}
