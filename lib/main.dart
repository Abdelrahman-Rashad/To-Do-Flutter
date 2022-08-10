import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/app/data/services/storage/sevices.dart';
import 'package:todo/app/middleware/MiddleWare.dart';
import 'package:todo/app/screen/home/binding.dart';
import 'package:todo/app/screen/home/widgets/demopagestate.dart';
import 'package:todo/app/screen/intro/intro.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

SharedPreferences? preferences;
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  await GetStorage.init();
  await Get.putAsync(() => StoreService().init());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
      )),
      colorScheme: ColorScheme.light().copyWith(primary: Colors.deepPurple),
      primaryColor: Colors.deepPurple,
      

      // ignore: prefer_const_constructors
      textTheme: TextTheme(
        headline1: const TextStyle(
            fontSize: 32, fontFamily: "Ubuntu-Medium.ttf", color: Colors.black),
        headline2: const TextStyle(
            fontSize: 17,
            fontFamily: "Ubuntu-Regular.ttf",
            color: Colors.black54),
        headline3: const TextStyle(
            fontSize: 24, fontFamily: "Ubuntu-Medium.ttf", color: Colors.white),
            headline4: const TextStyle(
            fontSize: 36, fontFamily: "Ubuntu-Medium.ttf", color: Colors.black,fontWeight: FontWeight.w500),
            headline5: const TextStyle(
            fontSize: 24, fontFamily: "Ubuntu-Medium.ttf", color: Colors.black,overflow: TextOverflow.ellipsis,fontWeight: FontWeight.w500),
            button: const TextStyle(
            fontSize: 25, fontFamily: "Ubuntu-Medium.ttf", color: Colors.deepPurple),
            headline6: const TextStyle(
            fontSize: 25, fontFamily: "Ubuntu-Medium.ttf", color: Colors.black,fontWeight: FontWeight.w400),
      ).apply(fontFamily: "Ubuntu")
      ),
      debugShowCheckedModeBanner: false,
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
      getPages: [
        GetPage(name: '/', page: ()=> Intro(),middlewares: [IntroMeddleWare()]),
        GetPage(name: '/Demo', page: ()=>Demopagestate())
      ],
    );
  }
}


