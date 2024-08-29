part of 'user_detail_cubit.dart';

@immutable
sealed class UserDetailState {}

final class UserDetailInitial extends UserDetailState {}

final class UserDetailLoading extends UserDetailState {}

final class UserDetailLodded extends UserDetailState {
  UserProfileModel userProfileModel;
  UserDetailLodded(this.userProfileModel);
}

final class UserDetailError extends UserDetailState {}
