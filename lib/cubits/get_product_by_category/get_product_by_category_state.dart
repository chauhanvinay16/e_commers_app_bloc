part of 'get_product_by_category_cubit.dart';

@immutable
sealed class GetProductByCategoryState {}

final class GetProductByCategoryInitial extends GetProductByCategoryState {}

final class GetProductByCategoryLoading extends GetProductByCategoryState {}

final class GetProductByCategoryLodded extends GetProductByCategoryState {
  final List<GetProductModal> getCategoriesProductModal;
  GetProductByCategoryLodded(this.getCategoriesProductModal);
}

final class GetProductByCategoryError extends GetProductByCategoryState {}

