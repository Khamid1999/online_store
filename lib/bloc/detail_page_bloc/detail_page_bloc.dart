
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/data/models/product_model.dart';


part 'detail_page_event.dart';
part 'detail_page_state.dart';

class DetailPageBloc extends Bloc<DetailPageEvent,DetailPageState>{
  DetailPageBloc() : super(DetailPageInitialState());
  }


