import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part  'products_event.dart';
part  'products_state.dart';


class ProductsBloc extends Bloc<ProductsEvent,ProductsState>{
  ProductsBloc(ProductsState initialState) : super(initialState);
}