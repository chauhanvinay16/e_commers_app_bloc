import 'package:bloc/bloc.dart';
import 'package:e_commers_app/helpers/storage_helper.dart';
import 'package:e_commers_app/network_manager/rest_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import '../../screen/bottem_bar_tabs.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  login({required String email,required String password,required BuildContext context}){

    emit(LoginLoading());

    Map requestBody={
      "email": email,
      "password": password
    };
    RestClient.login(requestBody).then((value) {
      emit(LoginLoaded());
      StorageHelper().setUserBearerToken(value['access_token']);
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => BottemBarTabs(),));
    },).onError((error, stackTrace) {
        emit(LoginError());
    },);
  }
}
