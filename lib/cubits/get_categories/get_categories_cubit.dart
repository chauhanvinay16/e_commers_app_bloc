import 'package:bloc/bloc.dart';
import 'package:e_commers_app/network_manager/rest_client.dart';
import 'package:meta/meta.dart';

import '../../models/get_catagories_modal.dart';

part 'get_categories_state.dart';

class GetCategoriesCubit extends Cubit<GetCategoriesState> {
  GetCategoriesCubit() : super(GetCategoriesInitial());

  getcategoriess(){
    emit(GetCategoriesLoading());
    RestClient.getcategories().then((value) {
      emit(GetCategoriesLodded(value));
    },).onError((error, stackTrace) {
      emit(GetCategoriesError());
    },);
  }
}
