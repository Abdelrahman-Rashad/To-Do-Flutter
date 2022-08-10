import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/app/core/keys.dart';
import 'package:todo/main.dart';

class IntroMeddleWare extends GetMiddleware{
  @override
  RouteSettings? redirect(String? route){
    if(preferences!.getBool(DISPLAYINTRO)!=null)
    return RouteSettings(name: '/Demo');
    
  }
}