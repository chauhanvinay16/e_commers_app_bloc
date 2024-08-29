import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:e_commers_app/models/chnage_profile_model.dart';
import 'package:e_commers_app/network_manager/rest_client.dart';
import 'package:meta/meta.dart';

part 'change_profile_state.dart';

class ChangeProfileCubit extends Cubit<ChangeProfileState> {
  ChangeProfileCubit() : super(ChangeProfileInitial());

  changeprofile(File selectedImage){
    emit(ChangeProfileLoading());

    RestClient.uploadimage(selectedImage).then((value) {
      emit(ChangeProfileLoadded(value));
    },).onError((error, stackTrace) {
      emit(ChangeProfileError());
    },);
  }
}
