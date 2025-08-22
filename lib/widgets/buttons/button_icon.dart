import 'package:flutter/material.dart';

class ButtonIconP extends StatelessWidget {
  
  final String? tooltip;
  final dynamic icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? colorIcon;
  final double? elevation;
  final double? radius;
  final EdgeInsetsGeometry? padding;

  const ButtonIconP({
    super.key,
    this.tooltip, 
    this.onPressed,
    this.backgroundColor,
    this.colorIcon,
    required this.icon, 
    this.elevation,
    this.radius,
    this.padding
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(4),
      child: IconButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(backgroundColor??Colors.white),
          elevation: WidgetStatePropertyAll(elevation ?? 0),
          shadowColor: const WidgetStatePropertyAll(Colors.black87),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular( radius ?? 10))
            )
          )
        ),
        tooltip: tooltip,
        icon: icon is IconData? Icon(icon, color: colorIcon ?? Colors.blue, size: 20) : icon,
        onPressed: onPressed,
      ),
    );
  }
}