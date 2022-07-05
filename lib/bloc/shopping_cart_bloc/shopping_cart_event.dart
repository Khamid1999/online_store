part of 'package:online_store/bloc/shopping_cart_bloc/shopping_cart_bloc.dart';



abstract class ShoppingCartEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class ShoppingCartAddProductEvent extends ShoppingCartEvent{
  final Product product;
  ShoppingCartAddProductEvent({required this.product});
  @override
  List<Object?> get props => [product];
}
class ShoppingCartRemoveProductEvent extends ShoppingCartEvent{
  final Product product;
  ShoppingCartRemoveProductEvent({required this.product});
  @override
  List<Object?> get props => [product];
}
class ShoppingCartTotalSumCount extends ShoppingCartEvent{
  final Product product;
  ShoppingCartTotalSumCount({required this.product});
  @override
  List<Object?> get props => [product];
}