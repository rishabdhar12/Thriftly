import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoPlus {
  static late PackageInfo packageInfo;

  static init() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  static String getVersion() {
    return packageInfo.version;
  }
}
