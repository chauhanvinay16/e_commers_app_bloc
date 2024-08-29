import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:e_commers_app/cubits/delete_product/delete_product_cubit.dart';
import 'package:e_commers_app/helpers/color_helper.dart';
import 'package:e_commers_app/helpers/dimens_helper.dart';
import 'package:e_commers_app/utiles/loadingindigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/get_product_by_category/get_product_by_category_cubit.dart';
import '../cubits/get_products/get_products_cubit.dart';

class DeleteProductButton extends StatelessWidget {
  final String id;
  final bool goback;
  final String? catagoryId;
  const DeleteProductButton({super.key, required this.id, required this.goback, this.catagoryId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DeleteProductCubit(),
      child: BlocConsumer<DeleteProductCubit, DeleteProductState>(
        listener: (BuildContext context, DeleteProductState state) {
          if(state is DeleteProductLoadded){
            if(goback){
              Navigator.pop(context,true);
            }
          }else{
            if(catagoryId==null){
              context.read<GetProductsCubit>().getproducts();
            }else{
              context.read<GetProductByCategoryCubit>().getProductByCategory(catagoryId!);
            }
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () async{
              context.read<DeleteProductCubit>().deteleproducts(id);
              print('Delete==>${id}');
              AnimatedSnackBar.material(
                  'Product Delete Successfully',
                  type: AnimatedSnackBarType.success,
                  mobileSnackBarPosition: MobileSnackBarPosition.bottom
              ).show(context);
            },
            child: Container(
              margin: const EdgeInsets.only(left: DimensHelper.dimens_10),
              alignment: Alignment.center,
              height: DimensHelper.dimens_40,
              width: DimensHelper.dimens_70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DimensHelper.dimens_50),
                border: Border.all(
                  color: ColorHelper.primaryColor,
                ),
              ),
              child: state is DeleteProductLoading ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: loadingIndigator(),
              ) :
              const Icon(Icons.delete, color: ColorHelper.red,),
            ),
          );
        },
      ),
    );
  }
}
