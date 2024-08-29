import 'package:e_commers_app/componats/delete_button.dart';
import 'package:e_commers_app/componats/edit_button.dart';
import 'package:e_commers_app/cubits/get_products/get_products_cubit.dart';
import 'package:e_commers_app/helpers/dimens_helper.dart';
import 'package:e_commers_app/helpers/font_helper.dart';
import 'package:e_commers_app/models/get_product_modal.dart';
import 'package:e_commers_app/network_manager/rest_client.dart';
import 'package:e_commers_app/screen/home/product_detail.dart';
import 'package:e_commers_app/utiles/loadingindigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helpers/color_helper.dart';
import '../../helpers/string_helper.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({super.key});

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {

  @override
  void initState() {
    // TODO: implement initState
    // RestClient.getproduct();
    context.read<GetProductsCubit>().getproducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringHelper.product,style: TextStyle(color: ColorHelper.whiteColor),),
        backgroundColor: ColorHelper.primaryColor,
      ),
      body: BlocBuilder<GetProductsCubit,GetProductsState>(
        builder: (context, state) {
          if(state is GetProductsLoading){
            return loadingIndigator();
          }else if(state is GetProductsError){
            return Center(child: Text(StringHelper.Somthingwrong),);
          }else if(state is GetProductsLoadded){
            return productList(state.getProductModal);
          }

          return SizedBox();
      },),
    );
  }
  Widget productList(List<GetProductModal> getProductModal){
    return ListView.separated(
        separatorBuilder: (context, i) => const SizedBox(height: DimensHelper.dimens_14,),
        itemCount: getProductModal.length,
        padding:const EdgeInsets.symmetric(vertical: DimensHelper.dimens_10,horizontal: DimensHelper.dimens_10),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async{
                var refresh= await Navigator.push(context, MaterialPageRoute(builder:  (context) => ProductDetailsScreen(getProductsModel: getProductModal[index],),));

                if(refresh == true){
                    context.read<GetProductsCubit>().getproducts();
                }
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
                      GestureDetector(
                        onTap: () {
                          if (getProductModal[index].category?.image != null && getProductModal[index].category!.image!.isNotEmpty) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop(); // Close the dialog when tapped outside the image
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Image.network(
                                        getProductModal[index].category!.image!,
                                        fit: BoxFit.contain, // Adjust the fit as per your requirement
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                        child: CircleAvatar(
                          maxRadius: 40,
                          backgroundImage: NetworkImage(getProductModal[index].category?.image ?? ""),
                        ),
                      ),

                      const Spacer(),

                      EditProductButton(
                          productId: getProductModal[index].id.toString(),
                          title: getProductModal[index].title.toString(),
                          category: getProductModal[index].category?.name??"",
                          price: getProductModal[index].price??0,
                      ),

                      DeleteProductButton(
                        id: getProductModal[index].id.toString(), goback: false,
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Text(getProductModal[index].title??"")),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("${StringHelper.price}: ",style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(" ₹${getProductModal[index].price.toString()??""}"),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("${StringHelper.category}: ",style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(getProductModal[index].category?.name??""),
                    ],
                  ),
                  const SizedBox(height: DimensHelper.dimens_10,),

                  Text(
                    getProductModal[index].description ?? "",
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
