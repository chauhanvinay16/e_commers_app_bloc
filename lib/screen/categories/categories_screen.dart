import 'package:e_commers_app/cubits/get_categories/get_categories_cubit.dart';
import 'package:e_commers_app/cubits/get_product_by_category/get_product_by_category_cubit.dart';
import 'package:e_commers_app/screen/categories/view_category_products.dart';
import 'package:e_commers_app/utiles/date_formate.dart';
import 'package:e_commers_app/utiles/loadingindigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helpers/color_helper.dart';
import '../../helpers/dimens_helper.dart';
import '../../helpers/font_helper.dart';
import '../../helpers/string_helper.dart';
import '../../models/get_catagories_modal.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<GetCategoriesCubit>().getcategoriess();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringHelper.category,style: TextStyle(color: ColorHelper.whiteColor),),
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
              return categorieslist(state.getCategoriesModal);
            }
            return const SizedBox();
          },
      ),
    );
  }
  Widget categorieslist(List<GetCategoriesModal> getCategoriesModal){
    return ListView.separated(
      itemCount: getCategoriesModal.length,
      padding: const EdgeInsets.symmetric(vertical: DimensHelper.dimens_10, horizontal: DimensHelper.dimens_10),
      separatorBuilder: (context, i)=> const SizedBox(height: DimensHelper.dimens_10,),
      itemBuilder: (context, index){
        return ListTile(
          onTap: (){
            print("catogaries tap");
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>
            //     BlocProvider(
            //         create: (BuildContext context) => GetProductsByCategoryCubit(),
            //         child: ViewCategoryProducts(id: getCategoriesModel[index].id.toString(),))));

            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                BlocProvider(
                create: (BuildContext context) => GetProductByCategoryCubit(),
                child: ViewCategoryProductsScreen(id: getCategoriesModal[index].id.toString(),)),));
          },
          leading: CircleAvatar(
            backgroundImage: NetworkImage(getCategoriesModal[index].image??""),
          ),
          title: Text(getCategoriesModal[index].name??""),
          subtitle: Text(dateformate(getCategoriesModal[index].creationAt??"")),
        );
      },
    );
  }
}
