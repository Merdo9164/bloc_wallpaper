import 'package:equatable/equatable.dart';

class Wallpaper extends Equatable {
  final String id;
  final String title;
  final String imageUrl;

  const Wallpaper({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  factory Wallpaper.fromJson(Map<String, dynamic> json) {
    return Wallpaper(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  //Equatable içeriklerin eşitliğini kontrol eder
  @override
  List<Object?> get props => [id, title, imageUrl];
}
