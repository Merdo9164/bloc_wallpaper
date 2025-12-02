import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

class WallpaperService {
  // Görseli indirip dosya yolunu döndür
  static Future<String> downloadImage(String url) async {
    final response = await http.get(Uri.parse(url));
    final documentDirectory = await getTemporaryDirectory();
    final file = File('${documentDirectory.path}/wallpaper.jpg');
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }

  // Ana ekran duvar kağıdını ayarla.
  static Future<void> setHomeWallpaper(String imagePath) async {
    await WallpaperManagerFlutter().setWallpaper(
      File(imagePath),
      WallpaperManagerFlutter.homeScreen,
    );
  }

  // Kilit ekran duvar kağıdını ayarla
  static Future<void> setLockScreenWallpaper(String imagePath) async {
    await WallpaperManagerFlutter().setWallpaper(
      File(imagePath),
      WallpaperManagerFlutter.lockScreen,
    );
  }
}
