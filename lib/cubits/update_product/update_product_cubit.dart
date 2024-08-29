import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:e_commers_app/models/update_product_model.dart';
import 'package:e_commers_app/network_manager/rest_client.dart';
import 'package:e_commers_app/screen/home/home_screen.dart';
import 'package:e_commers_app/utiles/toast_meaasge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'update_product_state.dart';

class UpdateProductCubit extends Cubit<UpdateProductState> {
  UpdateProductCubit() : super(UpdateProductInitial());

  updateProduct({
    required String title,
    required int price,
    required String productId,
    required BuildContext context, // Pass BuildContext
  }) {
    emit(UpdateProductLoading());
    Map params = {
      "title": title,
      "price": price.toString(),
    };
    RestClient.updateProduct(params, productId).then((value) {
      emit(UpdateProductLoaded());
      // toastMessage('Update Successful');
      AnimatedSnackBar.material(
          'Product Update Succesfully',
          type: AnimatedSnackBarType.success,
          mobileSnackBarPosition: MobileSnackBarPosition.bottom
      ).show(context);

      // Navigate to another screen
      Navigator.pop(context, MaterialPageRoute(builder: (context) => Home_screen(),)// Replace NewScreen with the screen you want to navigate to
      );
    }).onError((error, stackTrace) {
      print("Error==>${error.toString()}");
      emit(UpdateProductError());
    });
  }
}
