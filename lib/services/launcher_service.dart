import 'package:url_launcher/url_launcher.dart';

class LauncherService {
  static Future<bool> call(String phone) async {
    final uri = Uri.parse('tel:$phone');
    return launchUrl(uri);
  }

  static Future<bool> sms(String phone, {String message = ''}) async {
    final uri = Uri.parse('sms:$phone?body=${Uri.encodeComponent(message)}');
    return launchUrl(uri);
  }

  static Future<bool> openUrl(String url) async {
    final uri = Uri.parse(url);
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  static Future<bool> email(String email) async {
    final uri = Uri.parse('mailto:$email?subject=MyCityConnect Support');
    return launchUrl(uri);
  }
}
