import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TextFormFieldP extends StatefulWidget {
  
  //Parametros 
  String title;
  String? subTitle;
  TextEditingController controller;
  bool? password;
  bool? validarEmail;
  bool? validarPassword;
  bool? validarSpacing;
  Widget? icon;
  Color? colores;
  Color? letraColor;
  double? contentPadding;
  Widget? suffixIcon;
  bool? readOnly;
  int? valLength;
  bool? number;
  ValueChanged<String>? onChange;
  VoidCallback? onTap;
  int? maxLines;
  double? height;
  double? borderRadius;

  TextFormFieldP({
    super.key,
    required this.title,
    this.subTitle,
    required this.controller,
    this.password,
    this.validarEmail,
    this.validarPassword,
    this.validarSpacing,
    this.icon,
    this.colores,
    this.letraColor,
    this.contentPadding,
    this.suffixIcon,
    this.readOnly,
    this.valLength,
    this.number,
    this.onTap,
    this.onChange,
    this.maxLines,
    this.height,
    this.borderRadius
  });

  @override
  State<TextFormFieldP> createState() => _TextFormFieldPState();
}

class _TextFormFieldPState extends State<TextFormFieldP> {
  
  bool mostrarPassword = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.maxLines != null? null : widget.height,
      child: TextFormField(
        style: GoogleFonts.lato(
          textStyle: TextStyle(
            color: widget.letraColor,
            fontSize: 14
          )
        ),
        inputFormatters: widget.number != null && widget.number! ? 
          [
            FilteringTextInputFormatter.digitsOnly, // Permite solo dígitos
          ]
        :
          null,
        onChanged: widget.onChange,
        onTap: widget.onTap,
        readOnly: widget.readOnly != null? widget.readOnly! : false,
        obscureText: widget.password != null && widget.password!? mostrarPassword : false,
        controller: widget.controller,
        decoration: inputDecoration(),
        maxLines: widget.maxLines,
        validator: (value) {
          
          if (value == null || value.isEmpty) {
          
            return 'Este campo no puede estar vacio.';
          
          }else if(widget.validarSpacing != null && widget.validarSpacing! && widget.controller.text.contains(' ')){
            
            return EmailValidator.validate(widget.controller.text)?  null : "El nombre de usuario no puede contener espacios." ;
      
          }else if(widget.valLength != null && value.length < widget.valLength!){
            
            return 'El texto debe contener minimo ${widget.valLength!} caracteres.';
      
          }else if(widget.validarPassword != null && widget.validarPassword!){
      
            //VALIDACIONES CEN CASO DE SER CONTRASEÑA
            if (value.length < 8) {
              return 'La contraseña debe contener minimo 8 caracteres.';
            }else if (!RegExp(r'[0-9]').hasMatch(value)) {
              return 'La contraseña debe contener al menos un número.';
            }else if (!RegExp(r'[A-Z]').hasMatch(value)) {
              return 'La contraseña debe contener al menos una letra mayúscula.';
            }else if (!RegExp(r'[a-z]').hasMatch(value)) {
              return 'La contraseña debe contener al menos una letra minúscula.';
            }else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
              return 'La contraseña debe contener al menos un carácter especial.';
            }
      
          }
      
          return null;
        },
      ),
    );
  }

  InputDecoration inputDecoration(){
    return InputDecoration(
          contentPadding: widget.maxLines != null? const EdgeInsets.all(10.0) : widget.contentPadding ==  null? const EdgeInsets.symmetric(horizontal: 10,vertical: 0) : EdgeInsets.all(widget.contentPadding!),
          hintText: widget.title,
          hintStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
              color: Color.fromARGB(255, 139, 139, 139),
              fontSize: 14,
            )
          ),
          fillColor: widget.colores != null? widget.colores! :Colors.white,
          filled: true,
          floatingLabelStyle:const TextStyle(color: Colors.black),
          prefixIcon: widget.icon,
          errorStyle: const TextStyle(color: Colors.red),
          suffixIcon: widget.password != null && widget.password!? 
            IconButton(
              hoverColor: Colors.transparent,
              tooltip: 'Mostrar',
              onPressed: (){
                setState(() {
                  mostrarPassword = !mostrarPassword;
                });
              }, 
              icon: const Icon(Icons.remove_red_eye_outlined,color: Colors.green)
            )
          :
            widget.suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius ?? 10.0)),
            borderSide: BorderSide(color: Colors.black12,width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius ?? 10.0)),
            borderSide: BorderSide(color: Colors.black26,width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius ?? 10.0)),
            borderSide: BorderSide(color: Color.fromARGB(255, 255, 0, 0)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius ?? 10.0)),
            borderSide: BorderSide(color: Color.fromARGB(255, 255, 0, 0)),
          ),
        
        );
  }


}