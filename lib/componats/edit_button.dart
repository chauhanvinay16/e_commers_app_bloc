import 'package:e_commers_app/screen/add_product/update_product.dart';
import 'package:flutter/material.dart';

import '../helpers/color_helper.dart';
import '../helpers/dimens_helper.dart';
import '../helpers/string_helper.dart';

class EditProductButton extends StatelessWidget {
  final String productId,title,category;
  final int price;
  const EditProductButton({super.key, required this.productId, required this.title, required this.category, required this.price});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProductScreen(
            productId: productId,
            title: title,
            price: price,
            category: category
        ),));
      },
      child: Container(
        alignment: Alignment.center,
        height: DimensHelper.dimens_40,
        width: DimensHelper.dimens_70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DimensHelper.dimens_50),
            border: Border.all(color: ColorHelper.primaryColor)
        ),
        // child: Text(StringHelper.edit,style: TextStyle(color: ColorHelper.green,fontWeight: FontWeight.bold),),
        child: const Icon(Icons.edit,color: ColorHelper.green,),
      ),
    );
  }
}
