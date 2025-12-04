import 'package:equatable/equatable.dart';

abstract class WallpaperEvent extends Equatable {
  const WallpaperEvent();

  @override
  List<Object> get props => [];
}

//Lİste Yükleme olayı
class LoadWallpapers extends WallpaperEvent {
  const LoadWallpapers();
}

//Duvar Kağıdı Ayarlama olayı (Uı dan gelen parametreler)
class SetWallpaper extends WallpaperEvent {
  final String imageUrl;
  final bool isHomeScreen;
  final bool isLockScreen;

  const SetWallpaper({
    required this.imageUrl,
    required this.isHomeScreen,
    required this.isLockScreen,
  });

  @override
  List<Object> get props => [imageUrl, isHomeScreen, isLockScreen];
}

//Görseller Ön belleğe Alındı Olayı
class ImagesPrecached extends WallpaperEvent {
  final List<String> imageUrls;
  const ImagesPrecached(this.imageUrls);

  @override
  List<Object> get props => [imageUrls];
}
