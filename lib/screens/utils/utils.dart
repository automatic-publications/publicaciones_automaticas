import 'package:flutter/material.dart';

class Utils {

 message(BuildContext context_, String mensaje, Color color) {
  double iconSize = MediaQuery.of(context_).size.width < 720 ? 25 : 35;
  double fontSize = MediaQuery.of(context_).size.width < 720 ? 10 : 16; 
  return ScaffoldMessenger.of(context_).showSnackBar(
    SnackBar(
      backgroundColor: Color.fromARGB(255, 43, 43, 43),
      content: Row( 
        children: [
          Icon(Icons.info_outlined, color: color, size: iconSize),
          const SizedBox(width: 8), 
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('¡Informacion!', style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: fontSize)),
                Text(mensaje, style: TextStyle(color: Colors.white, fontSize: fontSize)), 
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.cancel_outlined, color: color),
            onPressed: () {
              ScaffoldMessenger.of(context_).hideCurrentSnackBar();
            },
          ),
        ],
      ),
      padding: EdgeInsets.all(10), 
      behavior: SnackBarBehavior.fixed,

    ),
  );
}

}