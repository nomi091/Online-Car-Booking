import 'package:flutter/material.dart';
import 'package:online_booking/utils/constants/color.dart';

import '../utils/constants/constants-width.dart';

Widget customButton({context, title}) {
  return Container(
    height: Constants.getHeight(context) * 0.06,
    width: Constants.getWidth(context) * 0.9,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: AppColor.buttonColor,
    ),
    child: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
