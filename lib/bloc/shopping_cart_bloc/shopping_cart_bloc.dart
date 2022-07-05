import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/data/models/product_model.dart';

part 'shopping_cart_event.dart';
part 'shopping_cart_state.dart';

class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {
  List<Product> productList = [];
  double sum = 0.0;

  double calculateTotalSum(){
    sum = 0;
    productList.forEach((element) {
      sum += element.price;
      print(element.price);
    }
    );
    return sum;
  }

  ShoppingCartBloc() : super(ShoppingCartInitial()) {
    on<ShoppingCartAddProductEvent>((event, emit)  {
      emit(ShoppingCartLoading());
      try {
        productList.add(event.product);
        emit(ShoppingCartLoaded());
        sum = calculateTotalSum();

      } catch (e) {
        emit(ShoppingCartError(e.toString()));
      }
    });
    on<ShoppingCartRemoveProductEvent>((event, emit)  {
      emit(ShoppingCartLoading());
      try {
        productList.remove(event.product);
        sum -=  event.product.price;
        emit(ShoppingCartLoaded());

      } catch (e) {
        emit(ShoppingCartError(e.toString()));
      }
    });
  }
}
