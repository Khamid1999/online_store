part of 'package:online_store/bloc/wish_list_bloc/wish_list_bloc.dart';




abstract class WishListState extends Equatable{
  @override
  List<Object?> get props => [];
}
class WishListInitial extends WishListState{}
class WishListLoading extends WishListState{}
class WishListLoaded extends WishListState{}
class WishListError extends WishListState{
  String? error;
  WishListError({required this.error});
}