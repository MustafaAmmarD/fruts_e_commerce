import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/core/utils/app_colors.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({super.key, required this.isChecked, required this.onChecked});

  final bool isChecked;
  final ValueChanged<bool> onChecked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChecked(!isChecked);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        width: 24,
        height: 24,
        decoration: ShapeDecoration(
          color: isChecked ? AppColors.primaryColor : Colors.white,
          shape:RoundedRectangleBorder(
            side: BorderSide(
              color: isChecked ? Colors.transparent : Color(0xffDCDEDE),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(8),
          )
          
          ),
          child: Icon(
            isChecked ? Icons.check : null,
            color: Colors.white,
            size: 16,
          ),
      ),
    );
  }
}