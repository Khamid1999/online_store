part of 'package:online_store/bloc/detail_page_bloc/detail_page_bloc.dart';

abstract class DetailPageState extends Equatable{
  @override
  List<Object?> get props => [];
}
class DetailPageInitialState extends DetailPageState{}
class DetailPageLoadingState extends DetailPageState{}
class DetailPageLoadedState extends DetailPageState{}