import '../data/wallpaper_api.dart';
import '../models/wallpaper.dart';
import '../data/wallpaper_service.dart';

class WallpaperRepository {
  final WallpaperApi wallpaperApi;

  WallpaperRepository({required this.wallpaperApi});

  // Bloc , veriyi Repository üzerinden çeker.
  //Liste Çekme İşlemi (API'yi kullanır)
  //Bloc bu metodu çağırır, Apıye gitme detayını bilmez
  Future<List<Wallpaper>> fetchWallpapers() async {
    return wallpaperApi.getAllWallpapers();
  }

  //Duvar kağıdı Ayarlama İşlemi (Service 'i kullanır)
  // Bloc bu metodu çağırır, indirme/ayarlama detayını bilmez.
  Future<void> applyWallpaper({
    required String imageUrl,
    required bool isHomeScreen,
    required bool isLockScreen,
  }) async {
    //UI dan gelen ayarları kontrol et
    if (!isHomeScreen && !isLockScreen) {
      throw Exception(
        "Duvar kağıdı uygulamak için en az bir konum seçilmelidir",
      );
    }

    // Görseli indir ve dosya yolunu al.
    // İndirme işlemi Service tarafından yapılır.
    final imagePath = await WallpaperService.downloadImage(imageUrl);

    //Uygulama Service tarafından yapılır
    if (isHomeScreen) {
      await WallpaperService.setHomeWallpaper(imagePath);
    }

    if (isLockScreen) {
      await WallpaperService.setLockScreenWallpaper(imagePath);
    }
  }
}
