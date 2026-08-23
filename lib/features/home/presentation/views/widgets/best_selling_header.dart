import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/features/best_selling_fruits/presentation/views/best_selling_view.dart';

class BestSellingHeader extends StatelessWidget {
  const BestSellingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, BestSellingView.routeName);
      },
      child: Row(
        children: [
          Text(
            'الأكثر مبيعاً',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700
            ),
          ),
          Spacer(),
          Text(
            ' المزيد',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF949D9E),
              fontWeight: FontWeight.w400
            ),
          )
        ],
      ),
    );
  }
}