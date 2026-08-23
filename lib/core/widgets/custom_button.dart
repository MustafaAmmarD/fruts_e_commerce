import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/core/utils/app_colors.dart';
import 'package:fruts_e_commerce/core/widgets/scale_on_tap.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onPressed, required this.text, this.isLoading = false});
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ScaleOnTap(
      onTap: isLoading ? () {} : onPressed,
      scaleFactor: 0.95,
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)
            ),
            backgroundColor: AppColors.primaryColor
          ),
          onPressed: isLoading ? null : onPressed,
          child: isLoading 
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
        ),
      ),
    );
  }
}