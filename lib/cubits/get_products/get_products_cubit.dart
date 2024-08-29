import 'package:bloc/bloc.dart';
import 'package:e_commers_app/models/get_product_modal.dart';
import 'package:meta/meta.dart';

import '../../network_manager/rest_client.dart';

part 'get_products_state.dart';

class GetProductsCubit extends Cubit<GetProductsState> {
  GetProductsCubit() : super(GetProductsInitial());

  getproducts(){
    emit(GetProductsLoading());
    RestClient.getproduct().then((value) {
      emit(GetProductsLoadded(value));
    },).onError((error, stackTrace) {
      emit(GetProductsError());
    },);
  }
}
