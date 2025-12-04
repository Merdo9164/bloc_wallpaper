import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_wallpaper/layout/main_layout.dart';

//Cubitin state i direk olarak AppScreen enum u olacak.
class NavigationCubit extends Cubit<AppScreen> {
  NavigationCubit() : super(AppScreen.home);

  void setPage(AppScreen newPage) {
    if (newPage != state) {
      emit(newPage);
    }
  }
}
