import 'package:e_commers_app/helpers/assets_helper.dart';
import 'package:e_commers_app/helpers/storage_helper.dart';
import 'package:e_commers_app/screen/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

import 'bottem_bar_tabs.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    debugPrint("UserBearerToken:==>${StorageHelper().getUserBearerToken()}");
    Future.delayed(Duration(seconds: 3),() {
      if(StorageHelper().getUserBearerToken()==""){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottemBarTabs(),));
      }

    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(AssetsHelper.splashImage),),
    );
  }
}
