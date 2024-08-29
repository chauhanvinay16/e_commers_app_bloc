
import 'dart:io';

import 'package:e_commers_app/models/add_product_request_modal.dart';
import 'package:e_commers_app/models/get_product_modal.dart';
import 'package:e_commers_app/models/update_product_model.dart';

import '../models/chnage_profile_model.dart';
import '../models/get_add_product_modal.dart';
import '../models/get_catagories_modal.dart';
import '../models/get_categories_product_modal.dart';
import '../models/user_profile_modal.dart';
import 'http_helper.dart';

class RestClient{
  static final HttpHelper _httpHelper=HttpHelper();
  static const baseurl="https://api.escuelajs.co";

  static Future<dynamic>login(Object requestBody)async{
    Map<String,dynamic>response=await _httpHelper.post(url: "$baseurl/api/v1/auth/login",requestBody: requestBody);
    return response;
  }

  static Future<UserProfileModel>userprofile()async{
    Map<String,dynamic>response=await _httpHelper.get(url: '$baseurl/api/v1/auth/profile',isRequireAuthorization: true);
    return UserProfileModel.fromJson(response);
  }

  static Future<List<GetProductModal>>getproduct()async{
    List<dynamic>response=await _httpHelper.get(url: '$baseurl/api/v1/products');
    return List<GetProductModal>.from(response.map((x)=>GetProductModal.fromJson(x)));
  }

  static Future<List<GetCategoriesModal>>getcategories()async{
    List<dynamic>response=await _httpHelper.get(url: '$baseurl/api/v1/categories');
    return List<GetCategoriesModal>.from(response.map((x)=>GetCategoriesModal.fromJson(x)));
  }

  static Future<List<GetProductModal>>getProductBycatagoriy(String id)async{
    List<dynamic>response=await _httpHelper.get(url: '$baseurl/api/v1/categories/$id/products');
    return List<GetProductModal>.from(response.map((x)=>GetProductModal.fromJson(x)));
  }

  static Future<GetAddProductModal>addProducts(AddProductRequestModal addProductRequstModel)async{
    Map<String,dynamic>response=await _httpHelper.post(url: '$baseurl/api/v1/products/',requestBody: addProductRequstModel);
    return GetAddProductModal.fromJson(response);
  }

  static Future<UpdateProductModel>updateProduct(Object requestBody,String productId)async{
    Map<String,dynamic>respons= await _httpHelper.put(url: '$baseurl/api/v1/products/$productId',requestBody: requestBody);
    return UpdateProductModel.fromJson(respons);
  }

  static Future<dynamic>deleteproduct(String id) async{
    dynamic response= await _httpHelper.delete(url: '$baseurl/api/v1/products/$id');
    return response;
  }

  static Future<ChangeProfileModel>uploadimage(File selectedImage)async{
    dynamic response=await _httpHelper.uploadImage(url: '$baseurl/api/v1/files/upload', imgeFile: selectedImage);
    return ChangeProfileModel.fromJson(response);
  }
}