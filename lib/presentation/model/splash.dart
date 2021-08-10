import 'dart:async';
import 'package:flutter/material.dart';
import 'package:moyori/app_model.dart';
import 'package:moyori/utils/force_update.dart';
import 'package:moyori/presentation/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:launch_review/launch_review.dart';

class SplashPageModel with ChangeNotifier, WidgetsBindingObserver {
  SplashPageModel({required this.context});
  BuildContext context;
  AppModel? appModel;

  instantiate() {
    appModel = Provider.of<AppModel>(context, listen: false);
    WidgetsBinding.instance?.addObserver(this);
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await Future.wait([appModel!.init(), Future.delayed(Duration(seconds: 1))]);
      if (await shouldUpdate()) {
         showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) {
              return AlertDialog(
                title: Center(child: Text("アプリバージョン確認")),
                content: Text("新しいバージョンのアプリがストアにリリースされています\nアップデートを実施してからご利用下さい"),
                actions: [
                  ElevatedButton(
                    child: Text("ストアへ移動"),
                    onPressed: () { 
                      LaunchReview.launch(androidAppId: "com.iyaffle.rangoli", iOSAppId: "585027354");
                    },
                  ),
                ],
              );
            }
        );
      } else {
        Navigator.of(context).pushReplacementNamed(HomePage.routeName);
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (AppLifecycleState.resumed == state) {
      appModel?.setupRemoteConfig();
    }
  }
}