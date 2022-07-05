import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/data/models/product_model.dart';

part 'wish_list_event.dart';
part 'wish_list_state.dart';

class WishListBloc extends Bloc<WishlistEvent, WishListState> {
  List<Product?> wishList = [];
  WishListBloc() : super(WishListInitial()) {
    on<WishListAddProduct>((event, emit)  {
      emit(WishListLoading(),);
      try {
         wishList.add(event.product);
         emit(WishListLoaded());
      } catch (e) {
        emit(WishListError(error: e.toString()));
      }
    }
    );
    on<WishListRemoveProduct>((event, emit) {
      emit(WishListLoading());
      try{
        wishList.remove(event.product);
        emit(WishListLoaded());
      } catch (e) {
        emit(WishListError(error: e.toString()));
      }
    });
  }
}
