import 'package:flutter/material.dart';

Text text({text, fontsize, fontweight, color}) {
  return Text(
    text,
    textAlign: TextAlign.start,
    overflow: TextOverflow.ellipsis,
    maxLines: 30,
    style: TextStyle(
      fontSize: fontsize,
      fontWeight: fontweight,
      color: color,
    ),
  );
}

Widget iconText({text, icon}) {
  return Padding(
    padding: const EdgeInsets.only(right: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
      
        //  text(text: text, fontweight:FontWeight.normal, fontsize: 18.0,),
        Container(
          child: icon,
        ),
          const SizedBox(
          width: 10,
        ),
        Text(
          text,
          textAlign: TextAlign.end,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.normal,
            // color: color,
          ),
        ),
      ],
    ),
  );
}
