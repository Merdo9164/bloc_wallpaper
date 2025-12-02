import 'package:equatable/equatable.dart';

class Wallpaper extends Equatable {
  final String id;
  final String title;
  final String imageUrl;
  final String description;

  const Wallpaper({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
  });

  factory Wallpaper.fromJson(Map<String, dynamic> json) {
    return Wallpaper(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
    );
  }

  //Equatable içeriklerin eşitliğini kontrol eder
  @override
  List<Object?> get props => [id, title, imageUrl, description];
}
