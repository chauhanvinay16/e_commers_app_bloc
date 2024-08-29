import 'package:e_commers_app/componats/delete_button.dart';
import 'package:e_commers_app/componats/edit_button.dart';
import 'package:e_commers_app/cubits/get_product_by_category/get_product_by_category_cubit.dart';
import 'package:e_commers_app/models/get_categories_product_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helpers/color_helper.dart';
import '../../helpers/dimens_helper.dart';
import '../../helpers/font_helper.dart';
import '../../helpers/string_helper.dart';
import '../../models/get_product_modal.dart';
import '../../utiles/loadingindigator.dart';
import '../home/product_detail.dart';

class ViewCategoryProductsScreen extends StatefulWidget {
  final String id;
  const ViewCategoryProductsScreen({super.key, required this.id});

  @override
  State<ViewCategoryProductsScreen> createState() => _ViewCategoryProductsScreenState();
}

class _ViewCategoryProductsScreenState extends State<ViewCategoryProductsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    // RestClient.getproduct();
    context.read<GetProductByCategoryCubit>().getProductByCategory(widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: ColorHelper.whiteColor,),
        title: Text(StringHelper.product,style: TextStyle(color: ColorHelper.whiteColor),),
        backgroundColor: ColorHelper.primaryColor,
        centerTitle: true,
      ),
      body: BlocBuilder<GetProductByCategoryCubit, GetProductByCategoryState>(
          builder: (context, state){
            if(state is GetProductByCategoryLoading){
              return loadingIndigator();
            }else if (state is GetProductByCategoryError){
              return const Center(child: Text(StringHelper.Somthingwrong),);
            }else if (state is GetProductByCategoryLodded){
              return productList(state.getCategoriesProductModal);
            }
            return const SizedBox();
          })
    );
  }
  Widget productList(List<GetProductModal>getCategoriesProductModal){
    return ListView.separated(
      separatorBuilder: (context, i) => const SizedBox(height: DimensHelper.dimens_14,),
      itemCount: getCategoriesProductModal.length,
      padding:const EdgeInsets.symmetric(vertical: DimensHelper.dimens_10,horizontal: DimensHelper.dimens_10),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder:  (context) => ProductDetailsScreen(getProductsModel: getCategoriesProductModal[index],),));
          },
          child: Container(
            padding:const EdgeInsets.symmetric(vertical: DimensHelper.dimens_10,horizontal: DimensHelper.dimens_10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DimensHelper.dimens_10),
                border: Border.all(color: ColorHelper.greyColor)
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Text("${StringHelper.price}: ",style: TextStyle(fontWeight: FontWeight.bold),),
                    CircleAvatar(
                      maxRadius: 40,
                      backgroundImage: NetworkImage(getCategoriesProductModal[index].category?.image??""),
                    ),
                    const Spacer(),
                    EditProductButton(
                        productId: getCategoriesProductModal[index].id.toString(),
                        title: getCategoriesProductModal[index].title.toString(),
                        category: getCategoriesProductModal[index].category?.name??"",
                        price: getCategoriesProductModal[index].price??0,
                    ),
                    DeleteProductButton(
                      id: getCategoriesProductModal[index].id.toString(),
                      goback: false,
                      catagoryId: widget.id,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(getCategoriesProductModal[index].title??""),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("${StringHelper.price}: ",style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(" ₹${getCategoriesProductModal[index].price.toString()??""}"),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("${StringHelper.category}: ",style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(getCategoriesProductModal[index].category?.name??""),
                  ],
                ),
                const SizedBox(height: DimensHelper.dimens_10,),

                Text(
                  getCategoriesProductModal[index].description ?? "",
                  style: TextStyle(
                    color: ColorHelper.greyColor,
                    fontSize: FontHelper.font_14,
                    fontWeight: FontHelper.regular,
                  ),
                  textAlign: TextAlign.justify,
                )

              ],
            ),
          ),
        );
      },
    );
  }
}
