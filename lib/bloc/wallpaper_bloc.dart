import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_wallpaper/bloc/wallpaper_event.dart';
import 'package:bloc_wallpaper/bloc/wallpaper_state.dart';
import 'package:bloc_wallpaper/data/wallpaper_repository.dart';
import 'package:flutter/material.dart';
import 'package:bloc_wallpaper/models/wallpaper.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperDataState> {
  final WallpaperRepository repository;

  WallpaperBloc({required this.repository}) : super(WallpaperInitial()) {
    // Event-Handler eşleştirmesi
    on<LoadWallpapers>(_onLoadWallpapers);
    on<SetWallpaper>(_onSetWallpaper);
  }

  // İşleyici 1: Duvar Kağıtları Listesini Yükle
  Future<void> _onLoadWallpapers(
    LoadWallpapers event,
    Emitter<WallpaperDataState> emit,
  ) async {
    emit(WallpaperLoading(state.wallpapers));

    try {
      final wallpapers = await repository.fetchWallpapers();

      // Başarılı: Loaded durumu yayınla
      emit(
        WallpaperLoaded(
          wallpapers: wallpapers,
          isImagePrecached: false,
          isSetting: false,
          lastError: null,
          setSuccess: false,
        ),
      );
    } catch (e) {
      log('Liste yükleme hatası: $e', name: 'WallpaperBloc');
      emit(
        WallpaperError(
          'Liste yüklenirken bir hata oluştu: ${e.toString()}',
          state.wallpapers,
        ),
      );
    }
  }

  // İşleyici 2: Duvar Kağıdını Ayarla
  Future<void> _onSetWallpaper(
    SetWallpaper event,
    Emitter<WallpaperDataState> emit,
  ) async {
    final currentState = state;
    // 1. Ayarlama Başladı: isSetting=true durumu yayınla
    emit(
      currentState.copyWith(
        isSetting: true,
        setSuccess: false,
        lastError: null,
      ),
    );

    try {
      await repository.applyWallpaper(
        imageUrl: event.imageUrl,
        isHomeScreen: event.isHomeScreen,
        isLockScreen: event.isLockScreen,
      );

      // 2. Ayarlama Başarılı: setSuccess=true durumu yayınla
      emit(
        currentState.copyWith(
          isSetting: false,
          setSuccess: true,
          lastError: null,
        ),
      );
    } catch (e) {
      log('Duvar kağıdı ayarlama hatası: $e', name: 'WallpaperBloc');

      // 3. Ayarlama Hatalı: lastError=hata mesajı durumu yayınla
      emit(
        currentState.copyWith(
          isSetting: false,
          setSuccess: false,
          lastError: 'Ayarlama sırasında bir hata oluştu: ${e.toString()}',
        ),
      );
    }
  }

  // Yan Etki Metodu: Bu metot artık sadece Event fırlatır ve görsel indirme işlemini yapar.
  // Bloc dışından (UI'dan) çağrılır.
  Future<void> precacheImages(
    BuildContext context,
    List<Wallpaper> wallpapers,
  ) async {
    if (state.isImagePrecached) return;

    final wallpapersToPrecache = wallpapers.take(5).toList();
    final loadFutures = wallpapersToPrecache.map((wallpaper) async {
      final imageProvider = NetworkImage(wallpaper.imageUrl);
      await precacheImage(imageProvider, context);
    });

    try {
      await Future.wait(loadFutures);
      // İşlem bittikten sonra BİR EVENT tetikler.
      add(
        ImagesPrecached(wallpapersToPrecache.map((w) => w.imageUrl).toList()),
      );
    } catch (e) {
      log('Görsel önbellekleme hatası: $e', name: 'WallpaperBloc');
      // Hata olsa bile bayrağı true yapmak için Event tetikliyoruz.
      add(
        ImagesPrecached(wallpapersToPrecache.map((w) => w.imageUrl).toList()),
      );
    }
  }
}
