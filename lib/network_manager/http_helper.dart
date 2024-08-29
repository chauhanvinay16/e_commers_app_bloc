import 'dart:async';
import 'dart:convert';
import 'package:e_commers_app/helpers/storage_helper.dart';
import 'package:e_commers_app/main.dart';
import 'package:e_commers_app/screen/login_screen/login_screen.dart';
import 'package:e_commers_app/utiles/toast_meaasge.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:io';
import '../utiles/print_value.dart';

class HttpHelper{

  Map<String, String> header (bool isRequireAuthorization) {
    if(isRequireAuthorization){
      return {"Content-Type":"application/json","Authorization": 'Bearer ${StorageHelper().getUserBearerToken()}',};
    }else{
      return {"Content-Type":"application/json"};
    }
  }
  //GET API HANDEL
  Future<dynamic> get({required String url,bool isRequireAuthorization=false})async{

    try{
      final apiresponse=await http.get(Uri.parse(url),headers: header(isRequireAuthorization));
      printValue(url,tag: "API GET URL");
      printValue(header(isRequireAuthorization),tag: "API HEDERS: ");
      printValue(apiresponse.body,tag: "API RESPONSE");

      return _returnresponse(response: apiresponse);
    }on SocketException{
      return null;
    }
  }

  //POST API HANDEL
  Future<dynamic> post({required String url, Object? requestBody, bool isRequireAuthorization=false})async{
    try{
      http.Response apiResponse;
      if(requestBody==null){
        apiResponse=await http.post(Uri.parse(url),headers: header(isRequireAuthorization));
      }else{
        apiResponse=await http.post(Uri.parse(url),body: jsonEncode(requestBody),headers: header(isRequireAuthorization));
      }

      printValue(url,tag: "API POST URL");
      printValue(header(isRequireAuthorization),tag: "API HEDERS: ");
      printValue(apiResponse.body,tag: "API RESPONSE");

      return _returnresponse(response: apiResponse);
    }on SocketException{
      return null;
    }
  }

  //PUT API HANDEL
  Future<dynamic> put({required String url, Object? requestBody, bool isRequireAuthorization = false}) async {

    try {
      http.Response apiResponse;
      if (requestBody == null) {
        apiResponse = await http.put(Uri.parse(url),);
      } else {
        apiResponse = await http.put(Uri.parse(url), body: requestBody);
      }

      printValue(url ,tag: "API POST URL: ",);
      printValue(requestBody ,tag: "API REQ BODY: ",);
      // printValue(Hed(isRequireAuthorization) ,tag: "API Header: ",);
      printValue(apiResponse.body ,tag: "API RESPONSE",);

      return _returnresponse(response: apiResponse);
    } on SocketException {
      return null;
    }
  }

  Future<dynamic> patch({required String url, Object? requestBody, bool isRequireAuthorization=false})async{
    if(isRequireAuthorization){
      header(isRequireAuthorization);
    }
    try{
      http.Response apiResponse;
      if(requestBody==null){
        apiResponse=await http.patch(Uri.parse(url),headers: header(isRequireAuthorization));
      }else{
        apiResponse=await http.patch(Uri.parse(url),body: requestBody,headers: header(isRequireAuthorization));
        // apiResponse=await http.post(Uri.parse(url),body: jsonEncode(requestBody),headers: apiHeaders);
      }

      printValue(url,tag: "API patch URL");
      printValue(header(isRequireAuthorization),tag: "API HEDERS: ");
      printValue(apiResponse.body,tag: "API RESPONSE");

      return _returnresponse(response: apiResponse);
    }on SocketException{
      return null;
    }
  }

  //DELETE API HANDEL
  Future<dynamic> delete({required String url, Object? requestBody, bool isRequireAuthorization=false})async{
    try{
      http.Response apiResponse;
      if(requestBody==null){
        apiResponse=await http.delete(Uri.parse(url),headers: header(isRequireAuthorization));
      }else{
        apiResponse=await http.delete(Uri.parse(url),body: header(isRequireAuthorization));
      }

      printValue(url,tag: "API DELETE URL");
      printValue(header(isRequireAuthorization),tag: "API HEDERS: ");
      printValue(apiResponse.body,tag: "API RESPONSE");

      return _returnresponse(response: apiResponse);
    }on SocketException{
      return null;
    }
  }

  //MULTIPART API HANDEL
  Future<dynamic>uploadImage({required File imgeFile,required String url})async{
    try{
      var request=http.MultipartRequest('POST',Uri.parse(url));
      request.headers.addAll({"Content-Type": "multipart/from-data"});

      request.files.add(
          await http.MultipartFile.fromPath(
              'file',
              imgeFile.path,
              filename: imgeFile.toString().split("/").last)
      );
      StreamedResponse streamedResponse=await request.send();
      http.Response response=await http.Response.fromStream(streamedResponse);

      printValue(url,tag: "API MULTIPART URL");
      printValue({"content-Type":"multipart/from-data"},tag: "API Header: ");
      printValue(response.body,tag: "API RESPONSE");

      return _returnresponse(response: response);
    }on SocketException{
      return null;
    }
  }

  dynamic _returnresponse({required http.Response response}){
    switch(response.statusCode){
      case 200:
        var responsejsone=json.decode(response.body);
        return responsejsone;

      case 201:
        var responsejsone=json.decode(response.body);
        return responsejsone;

      case 400:
        var decodedError=json.decode(response.body);
        if(decodedError.contantKey('message')){
        toastMessage(decodedError['message'].toString());
        }
        throw Exception('API Error Statuscode 400');

      case 401:
        StorageHelper().clearData();
        navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen(),));
        throw Exception("UNAUTHORIZED 401");

      case 500:
        throw Exception("Error Occured while Communication with Server with statuscode 500");

      default:
        throw Exception("Error occuring whhile communication with server with statuscode ${response.statusCode.toString()}");
    }
  }
}

