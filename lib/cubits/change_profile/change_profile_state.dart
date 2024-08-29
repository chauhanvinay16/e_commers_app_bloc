part of 'change_profile_cubit.dart';

@immutable
sealed class ChangeProfileState {}

final class ChangeProfileInitial extends ChangeProfileState {}

final class ChangeProfileLoading extends ChangeProfileState {}

final class ChangeProfileLoadded extends ChangeProfileState {
  final ChangeProfileModel changeProfileModel;
   ChangeProfileLoadded(this.changeProfileModel);
}

final class ChangeProfileError extends ChangeProfileState {}
