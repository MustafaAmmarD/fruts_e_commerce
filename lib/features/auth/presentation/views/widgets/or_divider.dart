import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 1,
            color: Color(0xffC9CECF),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18 ),
          child: Text(
            'أو',
            style: TextStyle(
              color: Color(0xff616A6B),
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 1,
            color: Color(0xffC9CECF),
          ),
        ),
      ],
    );
  }
}