import 'package:bloc/bloc.dart';
import 'package:e_commers_app/models/user_profile_modal.dart';
import 'package:e_commers_app/network_manager/rest_client.dart';
import 'package:meta/meta.dart';

part 'user_detail_state.dart';

class UserDetailCubit extends Cubit<UserDetailState> {
  UserDetailCubit() : super(UserDetailInitial());

  getuserdetail(){
      emit(UserDetailLoading());
      RestClient.userprofile().then((value) {
            emit(UserDetailLodded(value));
      },).onError((error, stackTrace) {
        emit(UserDetailError());
      },);
  }
}
