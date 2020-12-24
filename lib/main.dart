import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/routes.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());

}

class FlashChat extends StatelessWidget {

  void initState(){

  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      initialRoute:Routes.main,
      routes: {
        Routes.main: (context)=>WelcomeScreen(),
        Routes.login: (context)=>LoginScreen(),
        Routes.registration: (context) => RegistrationScreen(),
        Routes.chat: (context) => ChatScreen(),
      },
    );
  }
}
