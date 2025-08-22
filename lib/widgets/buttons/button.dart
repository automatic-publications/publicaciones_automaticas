import 'package:flutter/material.dart';

class ButtonPS extends StatefulWidget {
  final String title;
  final IconData? icon;
  final Color? colorIcon;
  final Color? colorText;
  final Color? colorHoverText;
  final Color? colorHover;
  final Color? background;
  final bool? bold;
  final Color? colorLoading;
  final bool? isLoading;
  final double? elevation;
  final bool? isPrimary;
  final VoidCallback onPressed;
  
  const ButtonPS({
    super.key, 
    required this.title,
    this.icon,
    this.background,
    this.colorIcon,
    this.colorText,
    this.colorHoverText,
    this.colorHover,
    this.bold,
    this.colorLoading,
    this.isLoading,
    this.elevation,
    this.isPrimary,
    required this.onPressed, 
  });

  @override
  State<ButtonPS> createState() => _ButtonPSState();
}

class _ButtonPSState extends State<ButtonPS> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: TextButton.icon(
        label: Text(widget.title, style: TextStyle(color: widget.colorText ?? Colors.black,fontWeight: widget.bold != null? FontWeight.bold : FontWeight.normal),),
        onPressed:  widget.isLoading != null && widget.isLoading!? null : widget.onPressed,
        icon: widget.isLoading != null && widget.isLoading!? 
            SizedBox(
              width:15,
              height: 15,
              child: CircularProgressIndicator(strokeWidth: 3,color: widget.colorLoading ?? Colors.orange)
            ) 
          : widget.icon != null? 
            Icon(
              widget.icon,
              size: 20,
              color: widget.colorIcon
            ) 
        :
        null,
        iconAlignment: IconAlignment.end,
        style: ButtonStyle(
          elevation:  WidgetStatePropertyAll(widget.elevation ?? 5),
          shadowColor: const WidgetStatePropertyAll(Colors.black54),
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 8.0,vertical: 10.0)),
          backgroundColor: WidgetStatePropertyAll(widget.background ?? Colors.white),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: widget.isPrimary != null && widget.isPrimary!? BorderSide.none : const BorderSide(color: Color.fromARGB(195, 45, 136, 131),width: 1)
            )
          )
        ),
      ),
    );
  }
}