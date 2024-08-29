import 'package:e_commers_app/cubits/add_product/add_product_cubit.dart';
import 'package:e_commers_app/helpers/dimens_helper.dart';
import 'package:e_commers_app/models/add_product_request_modal.dart';
import 'package:e_commers_app/utiles/toast_meaasge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/get_categories/get_categories_cubit.dart';
import '../../cubits/get_product_by_category/get_product_by_category_cubit.dart';
import '../../cubits/login/login_cubit.dart';
import '../../helpers/color_helper.dart';
import '../../helpers/font_helper.dart';
import '../../helpers/string_helper.dart';
import '../../models/get_catagories_modal.dart';
import '../../utiles/loadingindigator.dart';
import '../categories/view_category_products.dart';

class add_product_screen extends StatefulWidget {
  const add_product_screen({super.key});

  @override
  State<add_product_screen> createState() => _add_product_screenState();
}

class _add_product_screenState extends State<add_product_screen> {
  TextEditingController title=TextEditingController();
  TextEditingController Price=TextEditingController();
  TextEditingController description=TextEditingController();

  String categorytitle="Select Catagory";
  int? categoryid;
  final ExpansionTileController expansionTileController=ExpansionTileController();

  @override
  void initState() {
    // TODO: implement initState
    context.read<GetCategoriesCubit>().getcategoriess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringHelper.addProduct,style: TextStyle(color: ColorHelper.whiteColor),),
        backgroundColor: ColorHelper.primaryColor,
        centerTitle: true,
      ),
      body: BlocBuilder<GetCategoriesCubit,GetCategoriesState>(
        builder: (context, state) {
          if(state is GetCategoriesLoading){
            return loadingIndigator();
          }else if(state is GetCategoriesError){
            return const Center(child: Text(StringHelper.Somthingwrong),);
          }else if(state is GetCategoriesLodded){
            return contentWidget(state.getCategoriesModal);
          }
          return const SizedBox();
        },
      ),
    );
  }
  Widget contentWidget(List<GetCategoriesModal> getCategoriesModal){
    return ListView(
          padding: const EdgeInsets.symmetric(vertical: DimensHelper.dimens_10, horizontal: DimensHelper.dimens_10),
          children: [
            TextField(
              controller: title,
              decoration: const InputDecoration(hintText: StringHelper.title),
            ),
            SizedBox(height: DimensHelper.dimens_10,),
            TextField(
              controller: Price,
              decoration: const InputDecoration(hintText: StringHelper.price),
            ),
            SizedBox(height: DimensHelper.dimens_10,),
            TextField(
              controller: description,
              decoration: const InputDecoration(hintText: StringHelper.description),
            ),
            SizedBox(height: DimensHelper.dimens_10,),

            ExpansionTile(
                controller: expansionTileController,
                tilePadding: EdgeInsets.zero,
                title: Text(categorytitle),
                children: getCategoriesModal.map((e) => ListTile(
                  onTap: (){
                      categorytitle=e.name??"";
                      categoryid=e.id;
                      expansionTileController.collapse();
                      setState(() {

                      });
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(e.image??""),
                  ),
                  title: Text(e.name??""),
                )).toList(),
            ),
            SizedBox(height: DimensHelper.dimens_50,),

            SizedBox(
              height: 50,
              width: double.infinity,
              child: BlocProvider(
                create: (context) => AddProductCubit(),
                child: BlocConsumer<AddProductCubit, AddProductState>(
                  listener: (context, state) {
                    if(state is AddProductLodded){
                      toastMessage('Add Product Successfully');
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorHelper.primaryColor,
                            foregroundColor: ColorHelper.whiteColor
                        ),
                        onPressed: () {
                          if(state is AddProductLoading){

                          }else{

                                if(categoryid==null){
                                  toastMessage('Pleass Select Category');
                                }else{
                                  AddProductRequestModal addProductRequestModal=AddProductRequestModal(
                                    title: title.text,
                                    price: int.parse(Price.text),
                                    description: description.text,
                                    categoryId: categoryid,
                                    images: ['https://pub.dev/packages/flutter_bloc/versions/8.1.6/gen-res/gen/190x190/logo.webp']
                                  );
                                  context.read<AddProductCubit>().addProduct(addProductRequestModal);
                                }
                          }
                        },
                        child: state is AddProductLoading ?
                        const CircularProgressIndicator(color: ColorHelper.whiteColor,)
                            : const Text(StringHelper.addProduct,
                          style: TextStyle(fontSize: FontHelper.font_16),));
                  },
                ),
              ),
            )
          ],
        );
  }
}
