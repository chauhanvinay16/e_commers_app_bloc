part of 'get_categories_cubit.dart';

@immutable
sealed class GetCategoriesState {}

final class GetCategoriesInitial extends GetCategoriesState {}

final class GetCategoriesLoading extends GetCategoriesState {}

final class GetCategoriesLodded extends GetCategoriesState {
  final List<GetCategoriesModal> getCategoriesModal;
  GetCategoriesLodded(this.getCategoriesModal);
}

final class GetCategoriesError extends GetCategoriesState {}
