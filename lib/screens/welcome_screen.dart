import 'package:flash_chat/components/default_buttom.dart';
import 'package:flash_chat/routes.dart';
import 'package:flash_chat/tag_animation.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
  AnimationController aController;
  Animation animation;


  @override
  void initState() {
    super.initState();
    aController = AnimationController(duration: Duration(seconds: 1),vsync: this);
    animation = ColorTween(begin: Colors.grey,end: Colors.white).animate(aController);
    aController.forward();
    aController.addListener(() {
      setState(() {});
    });
  }
  @override
  void dispose(){
    super.dispose();
    aController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: TagAnimation.logo,
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                Text(
                  'Flash Chat',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            DefaultButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.login);
                },
              text:'Log In'),
            DefaultButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.registration);
                },
                text:'Register'),

          ],
        ),
      ),
    );
  }
}
