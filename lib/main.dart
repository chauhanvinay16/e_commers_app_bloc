import 'package:e_commers_app/cubits/get_categories/get_categories_cubit.dart';
import 'package:e_commers_app/cubits/get_products/get_products_cubit.dart';
import 'package:e_commers_app/cubits/user_detail/user_detail_cubit.dart';
import 'package:e_commers_app/screen/home/home_screen.dart';
import 'package:e_commers_app/screen/spash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'helpers/storage_helper.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await StorageHelper().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocProvider(create: (_) => UserDetailCubit(),),
        BlocProvider(create: (_) => GetProductsCubit(),),
        BlocProvider(create: (_) => GetCategoriesCubit(),),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}


