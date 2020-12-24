import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/default_buttom.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/routes.dart';
import 'package:flash_chat/tag_animation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool loading = false;
  String user;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: TagAnimation.logo,
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign:  TextAlign.center,
                onChanged: (value) {
                  user = value;
                },
                decoration: kInputDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign:  TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kInputDecoration.copyWith(hintText: 'Enter you password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              DefaultButton(
                  onPressed: () async{
                    setState(() {
                      loading =true;
                    });
                    try {
                      var userAuth = await _auth.signInWithEmailAndPassword(
                          email: user.trim(), password: password);
                      if (userAuth != null) {
                        Navigator.pushNamed(context, Routes.chat);
                      }
                    }catch(e){
                      print(e);
                    }
                    setState(() {
                      loading =false;
                    });

                  },
                  text:'Log In'),

            ],
          ),
        ),
      ),
    );
  }
}
