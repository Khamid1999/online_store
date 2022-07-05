part of 'package:online_store/bloc/wish_list_bloc/wish_list_bloc.dart';


abstract class WishlistEvent extends Equatable{
  @override
  List<Object?> get props => [];
}
class WishListAddProduct extends WishlistEvent{
 final Product product;
  WishListAddProduct({required this.product});
 @override
 List<Object?> get props => [product];
}
class WishListRemoveProduct extends WishlistEvent{
  final Product product;
  WishListRemoveProduct({required this.product});
  @override
  List<Object?> get props => [product];
}