part of 'package:online_store/bloc/detail_page_bloc/detail_page_bloc.dart';

abstract class DetailPageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class DetailPageRemoveItem extends DetailPageEvent{
  final Product product;
  DetailPageRemoveItem({required this.product});


  @override
  List<Object?> get props => [product];
}
class DetailPagePayCheck extends DetailPageEvent{}