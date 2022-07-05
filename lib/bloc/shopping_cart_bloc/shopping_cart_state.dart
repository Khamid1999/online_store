part of 'package:online_store/bloc/shopping_cart_bloc/shopping_cart_bloc.dart';



abstract class ShoppingCartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShoppingCartInitial extends ShoppingCartState {

}
class ShoppingCartLoaded extends ShoppingCartState{}
class ShoppingCartLoading extends ShoppingCartState{}
class ShoppingCartError extends ShoppingCartState{
 final String? error;
  ShoppingCartError(this.error);
}
