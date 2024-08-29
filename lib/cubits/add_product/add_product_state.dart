part of 'add_product_cubit.dart';

@immutable
sealed class AddProductState {}

final class AddProductInitial extends AddProductState {}

final class AddProductLoading extends AddProductState {}

final class AddProductLodded extends AddProductState {
  final GetAddProductModal getAddProductModal;
  AddProductLodded(this.getAddProductModal);
}

final class AddProductError extends AddProductState {}
