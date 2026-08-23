import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/core/utils/app_colors.dart';
import 'package:fruts_e_commerce/core/utils/app_text_styles.dart';

class CheckoutSteps extends StatelessWidget {
  const CheckoutSteps({
    super.key,
    required this.currentStep,
  });

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStep(context, 0, 'الشحن', currentStep),
        _buildStep(context, 1, 'العنوان', currentStep),
        _buildStep(context, 2, 'الدفع', currentStep),
        _buildStep(context, 3, 'المراجعة', currentStep),
      ],
    );
  }

  Widget _buildStep(BuildContext context, int stepIndex, String title, int currentStepIndex) {
    final isActive = stepIndex == currentStepIndex;
    final isCompleted = stepIndex < currentStepIndex;

    return Row(
      children: [
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive || isCompleted
                    ? AppColors.primaryColor
                    : Colors.white,
                border: Border.all(
                  color: isActive || isCompleted
                      ? AppColors.primaryColor
                      : const Color(0xFFF1F1F5),
                ),
              ),
              child: isCompleted
                  ? const Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.white,
                    )
                  : Center(
                      child: isActive
                          ? Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            )
                          : const SizedBox(),
                    ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: AppTextStyles.bold13.copyWith(
                color: isActive || isCompleted
                    ? AppColors.primaryColor
                    : const Color(0xFF949D9E),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
