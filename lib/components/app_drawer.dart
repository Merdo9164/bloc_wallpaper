import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_wallpaper/layout/main_layout.dart';
import 'package:bloc_wallpaper/bloc/navigation_cubit.dart';

// AppDrawer artık sade bir StatelessWidget olacak.
class AppDrawer extends StatelessWidget {
  final AppScreen activePage;
  const AppDrawer({required this.activePage, super.key});

  Widget _buildDrawerItem({
    required BuildContext context, // Cubit'i okumak için context gerekli
    required AppScreen page,
    required IconData icon,
    required String title,
  }) {
    // Cubit kullanarak sayfa değiştirme fonksiyonu
    void selectPage() {
      // NavigationCubit'e yeni sayfa event'i gönderilir.
      context.read<NavigationCubit>().setPage(page);

      // Çekmeceyi kapat
      Navigator.of(context).pop();
    }

    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: activePage == page,
      selectedTileColor: Colors.indigo.shade100,
      onTap: selectPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Tüm yapı artık sade StatelessWidget içinde
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Text(
              'Menü',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          // Her öğeye BuildContext ekledik
          _buildDrawerItem(
            context: context,
            page: AppScreen.home,
            icon: Icons.home,
            title: 'Ana Sayfa',
          ),
          _buildDrawerItem(
            context: context,
            page: AppScreen.favorites,
            icon: Icons.favorite,
            title: 'Favorilerim',
          ),
          _buildDrawerItem(
            context: context,
            page: AppScreen.settings,
            icon: Icons.settings,
            title: 'Ayarlar',
          ),
        ],
      ),
    );
  }
}
