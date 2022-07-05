import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String imageLink;
  final String type;
  final String id;
  Category({required this.imageLink, required this.type, required this.id});

  factory Category.fromMap(Map<String, dynamic> data) => Category(
        imageLink: data['image_link'],
        type: data['type'],
        id: data['id'],
      );

  @override
  List<Object?> get props => [imageLink,type,id];
}
