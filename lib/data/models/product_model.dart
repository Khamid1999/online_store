import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String description;
  final String imageLink;
  final String type;
  final num price;
  Product(
      {required this.description,
      required this.imageLink,
      required this.type,
      required this.price});

  factory Product.fromMap(Map<String, dynamic> data) => Product(
        type: data['type'],
        imageLink: data['image_link'],
        description: data['description'],
        price: data['price'],
      );

  @override
  List<Object?> get props => [description,imageLink,type,price];
}
