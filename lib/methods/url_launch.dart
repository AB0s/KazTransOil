import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static Future<void> launchInstagramURL() async {
    const url =
        'https://www.instagram.com/kaztransoil.official/?hl=ru';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<void> launchLinkedInURL() async {
    const url =
        'https://www.linkedin.com/company/kaztransoil/?originalSubdomain=kz';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<void> launchFacebookURL() async {
    const url = 'https://www.facebook.com/kaztransoil.official/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<void> launchYouTubeURL() async {
    const url =
        'https://www.youtube.com/channel/UCA1dV0LvPkg6e1PhIJ9eKOw';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  static Future<void> launchSource(id) async {
    final url =
        '$id';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  static Future<void> launchQorgauUrl() async {
    const url =
        'https://kaztransoil.kz/korgau';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  static Future<void> launchFileURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Pdf повреждён';
    }
  }
  static Future<void> launchYoutubeURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Не получилось загрузить';
    }
  }
}
