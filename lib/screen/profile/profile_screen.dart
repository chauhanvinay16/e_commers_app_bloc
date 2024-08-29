import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:e_commers_app/cubits/change_profile/change_profile_cubit.dart';
import 'package:e_commers_app/cubits/user_detail/user_detail_cubit.dart';
import 'package:e_commers_app/helpers/color_helper.dart';
import 'package:e_commers_app/helpers/font_helper.dart';
import 'package:e_commers_app/helpers/storage_helper.dart';
import 'package:e_commers_app/helpers/string_helper.dart';
import 'package:e_commers_app/models/user_profile_modal.dart';
import 'package:e_commers_app/screen/login_screen/login_screen.dart';
import 'package:e_commers_app/utiles/loadingindigator.dart';
import 'package:e_commers_app/utiles/toast_meaasge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class profile_screen extends StatefulWidget {
  const profile_screen({super.key});

  @override
  State<profile_screen> createState() => _profile_screenState();
}

class _profile_screenState extends State<profile_screen> {

  String profileImage="";

  @override
  void initState() {
    // TODO: implement initState
    // RestClient.userprofile();
    context.read<UserDetailCubit>().getuserdetail();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringHelper.Profile,style: TextStyle(color: ColorHelper.whiteColor),),
        backgroundColor: ColorHelper.primaryColor,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Logout'),
                      content: Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          child: Text('NO'),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                        TextButton(
                          child: Text('YES'),
                          onPressed: () {
                            StorageHelper().clearData();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                            );
                            Navigator.of(context).pop(); // Close the dialog
                            toastMessage('You are logged out!');
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Icon(
                Icons.login_outlined,
                color: ColorHelper.whiteColor,
              ),
            ),

          )
        ],
      ),
      body: BlocConsumer<UserDetailCubit,UserDetailState>(
        listener: (context, state) {
             if(state is UserDetailLodded){
                  // profileImage=state.userProfileModel.avatar??"";
             }
        },
        builder: (context, state) {
          if(state is UserDetailLoading){
              return loadingIndigator();
          }else if(state is UserDetailError){
            return const Center(child: Text(StringHelper.Somthingwrong),);
          }else if(state is UserDetailLodded){
            return userDetails(state.userProfileModel);
          }
          return const SizedBox();
      },),
    );
  }
  Widget userDetails(UserProfileModel userProfileModel){
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocProvider(
            create: (context) => ChangeProfileCubit(),
            child: BlocConsumer<ChangeProfileCubit, ChangeProfileState>(
            listener: (context, state) {
              if(state is ChangeProfileLoadded){
                  profileImage=state.changeProfileModel.location??"";
                  StorageHelper().setUserProfile(profileImage);
                  setState(() {

                  });
              }
            },
      builder: (context, state) {
      return InkWell(
            onTap: () async{
              // final XFile? photo = await picker.pickImage(source: ImageSource.camera);
              if(state is ChangeProfileLoading){

              }else{
                ImagePicker picker = ImagePicker();
                XFile? file = await picker.pickImage(source: ImageSource.gallery);

                if(file!=null){
                  context.read<ChangeProfileCubit>().changeprofile(File(file.path));
                }
              }
            },
            child: state is ChangeProfileLoading ?CircularProgressIndicator():
            CircleAvatar(
              radius: 58,
              backgroundImage: NetworkImage(profileImage==""? StorageHelper().getUserProfile():profileImage),
              child: const Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white70,
                        child: Icon(CupertinoIcons.camera),
                      ),
                    ),
                  ]
              ),
            ),
          );
  },
),
),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(

            ),
            child:FadeInUp(
              duration: const Duration(milliseconds: 1600),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11)
                    ),
                    label: Text('${userProfileModel.name}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                    prefixIcon: const Icon(Icons.person_pin)
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(

            ),
            child:FadeInUp(
              duration: const Duration(milliseconds: 1600),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11)
                    ),
                    label: Text('${userProfileModel.email}',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                    prefixIcon: const Icon(Icons.alternate_email_outlined,)
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(

            ),
            child:FadeInUp(
              duration: const Duration(milliseconds: 1600),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11)
                    ),
                    label: Text('${userProfileModel.role}',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                    prefixIcon: const Icon(Icons.verified_outlined)
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          FadeInUp(duration: const Duration(milliseconds: 1600), child: MaterialButton(
            onPressed: () {
                print("ontap==>BTN tap");
            },
            height: 52,
            // margin: EdgeInsets.symmetric(horizontal: 50),
            color: ColorHelper.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            // decoration: BoxDecoration(
            // ),
            child: const Center(
              child: Text("Update Profile", style: TextStyle(color: ColorHelper.whiteColor, fontWeight: FontWeight.bold,fontSize: FontHelper.font_14),),
            ),
          )),
        ],
      ),
    );
  }
}



