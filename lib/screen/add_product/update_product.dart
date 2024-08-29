import 'package:e_commers_app/cubits/update_product/update_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helpers/color_helper.dart';
import '../../helpers/dimens_helper.dart';
import '../../helpers/font_helper.dart';
import '../../helpers/string_helper.dart';
import '../../utiles/toast_meaasge.dart';

class UpdateProductScreen extends StatefulWidget {
  final String productId,title,category;
  final int price;
  const UpdateProductScreen({super.key, required this.productId, required this.title, required this.price, required this.category});
  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  TextEditingController title=TextEditingController();
  TextEditingController Price=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    title.text=widget.title;
    Price.text=widget.price.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: ColorHelper.whiteColor,),
        title: const Text(StringHelper.updateproduct,style: TextStyle(color: ColorHelper.whiteColor),),
        backgroundColor: ColorHelper.primaryColor,
        centerTitle: true,
      ),
      body: ListView(
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
          ListTile(
            title: Text(widget.category),
            subtitle: const Text("Category"),
          ),

          const SizedBox(height: DimensHelper.dimens_50,),

          SizedBox(
            height: 50,
            width: double.infinity,
            child: BlocProvider(
              create: (context) => UpdateProductCubit(),
              child: BlocBuilder<UpdateProductCubit, UpdateProductState>(

                builder: (context, state) {
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorHelper.primaryColor,
                          foregroundColor: ColorHelper.whiteColor
                      ),
                      onPressed: () {
                        if(state is UpdateProductLoading){

                        }else{

                          context.read<UpdateProductCubit>().updateProduct(
                              title: title.text,
                              price: int.parse(Price.text),
                              productId: widget.productId,
                              context: context,
                          );
                        }
                      },
                      child: state is UpdateProductLoading ?
                      const CircularProgressIndicator(color: ColorHelper.whiteColor,)
                          : const Text(StringHelper.submit,
                        style: TextStyle(fontSize: FontHelper.font_16),));
                },
              ),
            ),
          )
        ],
      )
    );
  }

}