part of 'get_products_cubit.dart';

@immutable
sealed class GetProductsState {}

final class GetProductsInitial extends GetProductsState {}

final class GetProductsLoading extends GetProductsState {}

final class GetProductsLoadded extends GetProductsState {
  final List<GetProductModal> getProductModal;
  GetProductsLoadded(this.getProductModal);
}

final class GetProductsError extends GetProductsState {}
