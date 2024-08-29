import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:e_commers_app/models/get_add_product_modal.dart';
import 'package:e_commers_app/network_manager/rest_client.dart';
import 'package:meta/meta.dart';

import '../../models/add_product_request_modal.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductInitial());
  
  addProduct(AddProductRequestModal addProductRequstModel){
    emit(AddProductLoading());
    print("Add Product Perams: ${jsonEncode(addProductRequstModel)}");
    RestClient.addProducts(addProductRequstModel).then((value) {
      emit(AddProductLodded(value));
    },).onError((error, stackTrace) {
      emit(AddProductError());
    },);
  }
}
