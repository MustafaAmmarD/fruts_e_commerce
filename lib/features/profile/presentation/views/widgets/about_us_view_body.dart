import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/core/utils/app_text_styles.dart';

class AboutUsViewBody extends StatelessWidget {
  const AboutUsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Center(
            child: Image.asset(
              'assets/images/logo.png', // Fallback to logo
              height: 100,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'من نحن',
            style: AppTextStyles.bold19,
          ),
          const SizedBox(height: 16),
          Text(
            'تطبيق FruitHub هو وجهتك الأولى لشراء أفضل وأجود أنواع الفواكه الطازجة. نحن نحرص على توصيل الطلبات بسرعة وبأعلى معايير الجودة لضمان رضا عملائنا.\n\nنهدف إلى توفير تجربة تسوق سهلة ومريحة عبر تطبيقنا الذي يتيح لك تصفح العديد من المنتجات، إضافتها إلى السلة، ومتابعة طلبك حتى يصل إلى باب منزلك.',
            style: AppTextStyles.regular16.copyWith(
              color: const Color(0xFF4E5556),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
