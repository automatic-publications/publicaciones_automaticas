import 'package:flutter/material.dart';
import 'package:publicaciones_automaticas/screens/home_screen.dart';
import 'package:publicaciones_automaticas/screens/login/login_screem.dart';
import 'package:publicaciones_automaticas/screens/user_profile.dart';

class Routes {
  
  final String login = "/";
  final String home = "/home";
  final String profile = "/profile";

  Map<String,  Widget Function(BuildContext)> generatedRoutes(){
    return {
      login: (_) => LoginScreem(),
      home: (_) => HomeScreen(),
      profile: (_) => UserProfile(),
    };
  }

}