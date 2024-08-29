import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper{
  static final StorageHelper _singleton = StorageHelper._internal();

  factory StorageHelper() {
    return _singleton;
  }

  StorageHelper._internal();

  late SharedPreferences sp;

  Future<void>init()async{
    sp=await SharedPreferences.getInstance();
  }

  void setUserBearerToken(String value){
    sp.setString('UserBearerToken',value);
  }

  void clearData(){
    sp.clear();
  }

  String getUserBearerToken(){
    return sp.getString('UserBearerToken')??"";
  }


  void setUserProfile (String url) {sp.setString('user_profile_url', url);}
  String getUserProfile () {return sp.getString('user_profile_url')??"";}
}