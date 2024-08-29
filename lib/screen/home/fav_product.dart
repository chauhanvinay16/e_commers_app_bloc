import 'dart:convert';
import 'package:e_commers_app/screen/home/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helpers/color_helper.dart';
import '../../helpers/font_helper.dart';
import '../../models/get_product_modal.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<GetProductModal> favoriteProducts = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteProducts();
  }

  _loadFavoriteProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> keys = prefs.getKeys().where((key) => key.startsWith('favoriteProduct_')).toSet();

    List<GetProductModal> products = [];
    for (String key in keys) {
      String? productData = prefs.getString(key);
      if (productData != null) {
        GetProductModal product = GetProductModal.fromJson(jsonDecode(productData));
        products.add(product);
      }
    }

    setState(() {
      favoriteProducts = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: ColorHelper.whiteColor,),
        title: Text("Favorite Products", style: TextStyle(color: ColorHelper.whiteColor),),
        backgroundColor: ColorHelper.primaryColor,
      ),
      body: favoriteProducts.isEmpty
          ? Center(child: Text("No favorite products", style: TextStyle(color: ColorHelper.blackColor, fontSize: FontHelper.font_18),))
          : ListView.builder(
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          GetProductModal product = favoriteProducts[index];
          return ListTile(
            title: Text(product.title ?? "", style: TextStyle(color: ColorHelper.primaryColor, fontSize: FontHelper.font_18, fontWeight: FontWeight.bold),),
            subtitle: Text("₹${product.price.toString()}", style: TextStyle(color: ColorHelper.blackColor, fontSize: FontHelper.font_16),),
            leading: product.images?.isNotEmpty == true ? Image.network(product.images!.first, width: 50, height: 50,) : null,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductDetailsScreen(getProductsModel: product)),
              );
            },
          );
        },
      ),
    );
  }
}
