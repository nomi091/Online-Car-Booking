import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
const List<Color> _kDefaultRainbowColors = [
  // Colors.red,
  // Colors.orange,
  Color.fromARGB(255, 230, 85, 13),
  Color.fromARGB(255, 233, 146, 31)
  // Colors.blue,
  // Colors.indigo,
  // Colors.purple,
];
class ProgressIndecator {
  static loadingIndecator() {
     return const SizedBox(
      height: 70,
      width: 70,
       child: LoadingIndicator(
        colors: _kDefaultRainbowColors,
        indicatorType: Indicator.ballClipRotate,
        strokeWidth: 2 ,
    
        // pathBackgroundColor: Colors.black45,
    ),
     );
  }
}
