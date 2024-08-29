import 'dart:convert';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../componats/delete_button.dart';
import '../../componats/edit_button.dart';
import '../../helpers/color_helper.dart';
import '../../helpers/dimens_helper.dart';
import '../../helpers/font_helper.dart';
import '../../helpers/string_helper.dart';
import '../../models/get_product_modal.dart';
import 'fav_product.dart';

class ProductDetailsScreen extends StatefulWidget {
  final GetProductModal getProductsModel;
  const ProductDetailsScreen({super.key, required this.getProductsModel});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  _loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = prefs.getBool('isFavorite_${widget.getProductsModel.id}') ?? false;
    });
  }

  _saveFavoriteStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = status;
    });

    String productKey = 'favoriteProduct_${widget.getProductsModel.id}';
    if (status) {
      String productData = jsonEncode(widget.getProductsModel.toJson());
      await prefs.setString(productKey, productData);
    } else {
      await prefs.remove(productKey);
    }

    prefs.setBool('isFavorite_${widget.getProductsModel.id}', status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: ColorHelper.whiteColor,),
        backgroundColor: ColorHelper.primaryColor,
        title: const Text(StringHelper.productdetail, style: TextStyle(color: ColorHelper.whiteColor),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(DimensHelper.dimens_20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  List<String> imageUrls = [
                    "${widget.getProductsModel.images?.first ?? ""}",
                    "${widget.getProductsModel.images?.last ?? ""}",
                    "${widget.getProductsModel.images?.last ?? ""}",
                  ];
                  return Image.network(
                    imageUrls[index],
                    height: 250,
                    width: 300,
                  );
                },
                itemCount: 3,
                pagination: SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.black54,
                    activeColor: Colors.red,
                  ),
                ),
                control: SwiperControl(
                  color: Colors.black54,
                ),
                autoplay: true,
                autoplayDelay: 3000,
              ),
            ),
            SizedBox(height: DimensHelper.dimens_20,),
            Row(
              children: [
                Expanded(child: Text(widget.getProductsModel.title ?? "", style: const TextStyle(color: ColorHelper.primaryColor, fontSize: FontHelper.font_18, fontWeight: FontWeight.bold),)),
                EditProductButton(
                  productId: widget.getProductsModel.id.toString(),
                  title: widget.getProductsModel.title.toString(),
                  category: widget.getProductsModel.category?.name ?? "",
                  price: widget.getProductsModel.price ?? 0,
                ),
                DeleteProductButton(id: widget.getProductsModel.id.toString(), goback: true,),
              ],
            ),
            const SizedBox(height: DimensHelper.dimens_10),
            Row(
              children: [
                const Text("${StringHelper.price}: ", style: TextStyle(color: ColorHelper.blackColor, fontSize: FontHelper.font_16, fontWeight: FontWeight.bold),),
                Text("₹${widget.getProductsModel.price.toString()}", style: const TextStyle(color: ColorHelper.blackColor, fontSize: FontHelper.font_16, fontWeight: FontWeight.bold),),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavorite==true ? Center(child: CircularProgressIndicator()):
                      isFavorite = !isFavorite;
                      _saveFavoriteStatus(isFavorite);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FavoritesPage()),
                      );

                    });
                  },
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? ColorHelper.red : Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: DimensHelper.dimens_10),
            Row(
              children: [
                const Text("${StringHelper.category}: ", style: TextStyle(color: ColorHelper.blackColor, fontSize: FontHelper.font_14, fontWeight: FontWeight.bold),),
                Text(widget.getProductsModel.category?.name ?? "", style: const TextStyle(color: ColorHelper.blackColor, fontSize: FontHelper.font_14, fontWeight: FontWeight.bold),),
              ],
            ),
            const SizedBox(height: DimensHelper.dimens_10,),
            Text(
              widget.getProductsModel.description ?? "",
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
  }
}
