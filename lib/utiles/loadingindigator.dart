import 'package:e_commers_app/helpers/color_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget loadingIndigator({Color?color}){
  return Center(child: CircularProgressIndicator(color:color?? ColorHelper.primaryColor,),);
}