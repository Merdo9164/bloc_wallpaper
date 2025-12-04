import 'package:equatable/equatable.dart';
import 'package:bloc_wallpaper/models/wallpaper.dart';

abstract class WallpaperState extends Equatable {
  const WallpaperState();

  @override
  List<Object?> get props => [];
}

//Ortak Durum Sınıfı: Uygulamanın anlık durumu için tek bir State yapısı kullanıyoruz.
class WallpaperDataState extends WallpaperState {
  final List<Wallpaper> wallpapers;
  final bool isImagePrecached;
  final bool isSetting;
  final String? lastError;
  final bool setSuccess;

  const WallpaperDataState({
    this.wallpapers = const [],
    this.isImagePrecached = false,
    this.isSetting = false,
    this.lastError,
    this.setSuccess = false,
  });

  // copyWith metodu ile mevcut durumun sadece belirli alanlarını güncelleriz
  WallpaperDataState copyWith({
    List<Wallpaper>? wallpapers,
    bool? isImagePrecached,
    bool? isSetting,
    String? lastError,
    bool? setSuccess,
  }) {
    return WallpaperDataState(
      wallpapers: wallpapers ?? this.wallpapers,
      isImagePrecached: isImagePrecached ?? this.isImagePrecached,
      isSetting: isSetting ?? this.isSetting,
      lastError: lastError,
      setSuccess: setSuccess ?? this.setSuccess,
    );
  }

  @override
  List<Object?> get props => [
    wallpapers,
    isImagePrecached,
    isSetting,
    lastError,
    setSuccess,
  ];
}

//ilk başlangıç durumu
class WallpaperInitial extends WallpaperDataState {}

//Liste Yükleniyor Durumu
class WallpaperLoading extends WallpaperDataState {
  const WallpaperLoading(List<Wallpaper> wallpapers)
    : super(wallpapers: wallpapers);
}

//Veri Yüklendi Durumu
class WallpaperLoaded extends WallpaperDataState {
  const WallpaperLoaded({
    required List<Wallpaper> wallpapers,
    required bool isImagePrecached,
    required bool isSetting,
    required String? lastError,
    required bool setSuccess,
  }) : super(
         wallpapers: wallpapers,
         isImagePrecached: isImagePrecached,
         isSetting: isSetting,
         lastError: lastError,
         setSuccess: setSuccess,
       );
  @override
  List<Object?> get props => [
    wallpapers,
    isImagePrecached,
    isSetting,
    lastError,
    setSuccess,
  ];
}

//Hata Durumu(liste ve Ayarlama hatası)
class WallpaperError extends WallpaperDataState {
  final String message;

  const WallpaperError(this.message, List<Wallpaper> wallpapers)
    : super(wallpapers: wallpapers, lastError: message);
}
