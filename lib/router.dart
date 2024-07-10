import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktalk/chat/screens/chat_screen.dart';
import 'auth/screens/opt_screen.dart';

Route<dynamic> genereateRoute(RouteSettings settings){
  switch(settings.name){
    case OTPScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const OTPScreen(),
      );
    case ChatScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const ChatScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => Container(),
      );
  }
}