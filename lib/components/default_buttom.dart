import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class DefaultButton extends StatelessWidget{
  final String _text;
  final Color _color;
  final Function _onPressed;
  DefaultButton({text,@required onPressed, color = Colors.lightBlue}):
      _text = text,
      _onPressed = onPressed,
      _color = color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: _color,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: _onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            _text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }



}