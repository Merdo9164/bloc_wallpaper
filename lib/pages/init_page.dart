import 'package:bloc_wallpaper/bloc/navigation_cubit.dart';
import 'package:bloc_wallpaper/bloc/wallpaper_state.dart';
import 'package:bloc_wallpaper/layout/main_layout.dart';
import 'package:bloc_wallpaper/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_wallpaper/data/wallpaper_api.dart';
import 'package:bloc_wallpaper/data/wallpaper_repository.dart';
import 'package:bloc_wallpaper/bloc/wallpaper_bloc.dart';
import 'package:bloc_wallpaper/bloc/wallpaper_event.dart';

class InitPage extends StatelessWidget {
  const InitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WallpaperApi>(create: (context) => WallpaperApi()),

        RepositoryProvider(
          create: (context) => WallpaperRepository(
            wallpaperApi: RepositoryProvider.of<WallpaperApi>(context),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WallpaperBloc>(
            create: (context) {
              final repository = RepositoryProvider.of<WallpaperRepository>(
                context,
              );
              return WallpaperBloc(repository: repository)
                ..add(const LoadWallpapers());
            },
          ),
          //GEzinme Cubit i(Sayfa Değiştirme)
          BlocProvider(create: (context) => NavigationCubit()),
        ],
        child: const _InitPageListener(),
      ),
    );
  }
}

// Bloc u dinleyen özel bir widget oluşturuyoruz.
class _InitPageListener extends StatelessWidget {
  const _InitPageListener();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WallpaperBloc, WallpaperDataState>(
      buildWhen: (previous, current) =>
          current is WallpaperInitial ||
          current is WallpaperLoading ||
          current is WallpaperError ||
          current is WallpaperLoaded,

      builder: (context, state) {
        if (state is WallpaperInitial || state is WallpaperLoading) {
          return const SplashScreen();
        }

        if (state is WallpaperError) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 50,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Veri Yüklenirken Hata Oluştu:',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        //Tekrar Yükleme eventı fırlat
                        context.read<WallpaperBloc>().add(
                          const LoadWallpapers(),
                        );
                      },
                      child: const Text('Tekrar Dene'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const MainLayout(child: HomePage());
      },
    );
  }
}
