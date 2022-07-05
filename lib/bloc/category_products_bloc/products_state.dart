part of 'package:online_store/bloc/category_products_bloc/products_bloc.dart';

abstract class ProductsState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ProductsInitialState extends ProductsState {}

class ProductsLoadedState extends ProductsState {}

class ProductsLoadingState extends ProductsState {}

class ProductsFailState extends ProductsState {}
