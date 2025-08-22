import 'package:flutter/material.dart';

import '../buttons/button_icon.dart';
import 'textformfield_p_icon.dart';

class SearchBarP extends StatelessWidget {

  final String? title;
  final double? width;
  final double padding;
  final TextEditingController controller;
  final VoidCallback onPress;
  final bool? isLoading;
  final Color? colorLoading;
  final Function(String)? onChange;
  
  const SearchBarP({
    super.key,
    this.title,
    this.width,
    required this.padding,
    required this.controller,
    required this.onPress,
    this.isLoading,
    this.colorLoading,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(padding),
      width: width ?? 400,
      child: TextFormFieldP(
        title: title ?? 'Buscar', 
        subTitle: '', 
        controller: controller, 
        password: false, 
        validarEmail: false, 
        colores: Colors.white, 
        letraColor: Colors.black,
        suffixIcon: ButtonIconP(
          onPressed: isLoading != null && isLoading!? null : onPress, 
          radius: 30,
          backgroundColor: Colors.blue,
          colorIcon: Colors.white,
          icon: isLoading != null && isLoading!? 
            SizedBox(
              width:15,
              height: 15,
              child: CircularProgressIndicator(strokeWidth: 3,color: colorLoading ?? Colors.white)
            )
          : Icons.search
        ),
        onChange: onChange,
      ),
    );
  }
}