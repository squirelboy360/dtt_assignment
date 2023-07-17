import 'package:flutter/cupertino.dart';

class Shapes{
  RoundedRectangleBorder roundedShapeBorder1( ){
    return const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20))
    );
  }
}