import 'package:flutter/material.dart';

class TextRichP extends StatelessWidget {
  
  final List<Map> data;

  const TextRichP({
    super.key,
    required this.data
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
          TextSpan(
            children: data.map(( item ) => TextSpan(
            text: item['title'] ?? '',
            style: TextStyle(
              color: item['color'] ?? Colors.black,
              fontSize: item['size'] ?? 16,
              fontWeight: item['bold'] != null? FontWeight.bold : FontWeight.normal
            )
          )
        ).toList()
      ),
      maxLines: 1, 
      overflow: TextOverflow.ellipsis,
    );
  }
}