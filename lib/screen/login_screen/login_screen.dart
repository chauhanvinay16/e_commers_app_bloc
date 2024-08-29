import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:e_commers_app/helpers/color_helper.dart';
import 'package:e_commers_app/helpers/dimens_helper.dart';
import 'package:e_commers_app/helpers/font_helper.dart';
import 'package:e_commers_app/helpers/string_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/login/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorHelper.primaryColor,
        title: const Text(
          StringHelper.login, style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailcontroller,
              decoration: const InputDecoration(
                label: Text(StringHelper.enteremail),
              ),
            ),
            const SizedBox(height: DimensHelper.dimens_20,),
            TextField(
              controller: passcontroller,
              decoration: const InputDecoration(
                label: Text(StringHelper.enterpassword),
              ),
            ),
            const SizedBox(height: DimensHelper.dimens_40,),

            SizedBox(
              height: 50,
              width: double.infinity,
              child: BlocProvider(
                create: (context) => LoginCubit(),
                child: BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorHelper.primaryColor,
                            foregroundColor: ColorHelper.whiteColor
                        ),
                        onPressed: () {
                          if(state is LoginLoading){
                            AnimatedSnackBar.material(
                                'Pleass Wait Data Are Loading',
                                type: AnimatedSnackBarType.success,
                                mobileSnackBarPosition: MobileSnackBarPosition.bottom
                            ).show(context);
                          }else{
                            context.read<LoginCubit>().login(
                                email: emailcontroller.text,
                                password: passcontroller.text,
                                context: context
                            );
                            AnimatedSnackBar.material(
                                'Login Sucsessfull',
                                type: AnimatedSnackBarType.success,
                                mobileSnackBarPosition: MobileSnackBarPosition.bottom
                            ).show(context);
                          }
                        },
                        child: state is LoginLoading ?
                        const CircularProgressIndicator(color: ColorHelper.whiteColor,)
                        : const Text(StringHelper.login,
                          style: TextStyle(fontSize: FontHelper.font_16),));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
