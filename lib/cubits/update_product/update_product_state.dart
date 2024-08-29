part of 'update_product_cubit.dart';

@immutable
sealed class UpdateProductState {}

final class UpdateProductInitial extends UpdateProductState {}

final class UpdateProductLoading extends UpdateProductState {}

final class UpdateProductLoaded extends UpdateProductState {}

final class UpdateProductError extends UpdateProductState {}
