import 'package:bloc/bloc.dart';
import 'package:e_commers_app/network_manager/rest_client.dart';
import 'package:meta/meta.dart';

part 'delete_product_state.dart';

class DeleteProductCubit extends Cubit<DeleteProductState> {
  DeleteProductCubit() : super(DeleteProductInitial());

  deteleproducts(String id){
    emit(DeleteProductLoading());
    RestClient.deleteproduct(id).then((value) {
      emit(DeleteProductLoadded());
    },).onError((error, stackTrace) {
      emit(DeleteProductError());
    },);
  }
}
