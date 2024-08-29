import 'package:bloc/bloc.dart';
import 'package:e_commers_app/models/get_product_modal.dart';
import 'package:e_commers_app/network_manager/rest_client.dart';
import 'package:meta/meta.dart';
part 'get_product_by_category_state.dart';

class GetProductByCategoryCubit extends Cubit<GetProductByCategoryState> {
  GetProductByCategoryCubit() : super(GetProductByCategoryInitial());

  getProductByCategory(String id){
    emit(GetProductByCategoryLoading());
    RestClient.getProductBycatagoriy(id).then((value) {
      emit(GetProductByCategoryLodded(value));
    },).onError((error, stackTrace) {
      emit(GetProductByCategoryError());
    },);
  }
}
