import 'package:package_info/package_info.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:moyori/utils/remote_config.dart';

Future<bool> shouldUpdate() async {
  final requiredVersion = Version.parse(remoteConfig.getString('force_update'));
  final packageInfo = await PackageInfo.fromPlatform();
  return Version.parse(packageInfo.version).compareTo(requiredVersion).isNegative;
}