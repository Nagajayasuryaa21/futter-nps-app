import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;
class CommonUtils{
  static void openStore(){
    if (Platform.isAndroid || Platform.isIOS) {
      final appId = Platform.isAndroid ? 'com.crm.kapturefieldservice' : '6475958653';
      final url = Uri.parse(
        Platform.isAndroid
            ? "market://details?id=$appId"
            : "https://apps.apple.com/app/id$appId",
      );
      launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}