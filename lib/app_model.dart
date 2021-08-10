import 'package:firebase_core/firebase_core.dart';
import 'package:moyori/utils/remote_config.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

RemoteConfig firebaseRemoteConfig = RemoteConfig.instance;

class AppModel {
  AppModel();
  String initialRoute = "/splash";

  Future init() async {
    await Firebase.initializeApp();
    await setupRemoteConfig();
  }

  Future setupRemoteConfig() async {
    await setupFirebaseRemoteConfig();
  }
}