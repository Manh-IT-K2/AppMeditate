import 'package:flutter/material.dart';

class Primaryfont{

  static String fontfamily ='HelveticaNeue';
  static TextStyle thin(double size){
    return TextStyle(
      fontFamily: fontfamily,
      fontWeight: FontWeight.w100,
      fontSize: size,
    );
  }
  static TextStyle ligh(double size){
    return TextStyle(
      fontFamily: fontfamily,
      fontWeight: FontWeight.w300,
      fontSize: size,
    );
  }
  static TextStyle medium(double size){
    return TextStyle(
      fontFamily: fontfamily,
      fontWeight: FontWeight.w600,
      fontSize: size,
    );
  }
  static TextStyle bold(double size){
    return TextStyle(
      fontFamily: fontfamily,
      fontWeight: FontWeight.w700,
      fontSize: size,
    );
  }

}

extension GetOrientation on BuildContext{
  Orientation get orientation => MediaQuery.of(this).orientation;
}

extension GetSize on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
}