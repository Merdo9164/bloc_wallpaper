import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/wallpaper.dart';

class WallpaperApi {
  final String baseUrl;

  WallpaperApi({required this.baseUrl});

  Future<List<Wallpaper>> getAllWallpapers() async {
    final response = await http.get(Uri.parse('$baseUrl/api/wallpaper'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Wallpaper.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load wallpapers');
    }
  }
}
