import 'package:package_info/package_info.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

RemoteConfig remoteConfig = RemoteConfig.instance;

Future setupFirebaseRemoteConfig() async {
  try {
    final info = await PackageInfo.fromPlatform();
    final appVersion = info.version;
    await remoteConfig.setDefaults(<String, dynamic>{
      'admob_banner_enabled': false,
      'force_update': appVersion,
      }
    );
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 20),
      minimumFetchInterval: const Duration(minutes: 60),
    ));
    await remoteConfig.fetchAndActivate();
  } on Exception catch (_) {
    await remoteConfig.activate();
  } 
}