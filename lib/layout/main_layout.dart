import 'package:bloc_wallpaper/components/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_wallpaper/bloc/navigation_cubit.dart';

// Enum, Bloc ve UI tarafından ortak kullanılır.
enum AppScreen { home, favorites, settings }

// MainLayout artık StatelessWidget olacak
class MainLayout extends StatelessWidget {
  // InitPage'den çocuk widget alması için düzenledik (Opsiyonel)
  final Widget? child;
  const MainLayout({super.key, this.child});

  Widget _getBodyContent(AppScreen activePage) {
    switch (activePage) {
      case AppScreen.home:
        // InitPage içinde zaten HomePage'i sarmalamıştık.
        // Eğer InitPage'den geliyorsa, child'ı göster (Bu genellikle HomePage'dir).
        return child ?? const Center(child: Text("Home Content Placeholder"));
      case AppScreen.favorites:
        return const FavoritesPage();
      case AppScreen.settings:
        return const SettingsPage();
    }
  }

  String _getTitle(AppScreen activePage) {
    switch (activePage) {
      case AppScreen.home:
        return 'Tüm Duvar Kağıtları';
      case AppScreen.favorites:
        return 'Favorilerim';
      case AppScreen.settings:
        return 'Ayarlar';
    }
  }

  @override
  Widget build(BuildContext context) {
    // BlocBuilder ile NavigationCubit'i dinliyoruz.
    return BlocBuilder<NavigationCubit, AppScreen>(
      builder: (context, activePage) {
        return Scaffold(
          appBar: AppBar(
            title: Text(_getTitle(activePage)),
            backgroundColor: Colors.indigo.shade700,
            foregroundColor: Colors.white,
          ),

          // AppDrawer'ın da Cubit'i kullanması gerekecek.
          drawer: AppDrawer(activePage: activePage),

          body: _getBodyContent(activePage),
        );
      },
    );
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite, size: 48, color: Colors.pink),
          Text('Favori Duvar Kağıtları Listesi'),
        ],
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.settings, size: 48, color: Colors.grey),
          Text('Ayarlar'),
        ],
      ),
    );
  }
}
