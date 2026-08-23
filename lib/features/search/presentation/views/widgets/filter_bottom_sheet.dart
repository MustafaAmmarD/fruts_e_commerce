import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/utils/app_colors.dart';
import 'package:fruts_e_commerce/core/utils/app_text_styles.dart';
import 'package:fruts_e_commerce/core/widgets/custom_button.dart';
import 'package:fruts_e_commerce/features/search/presentation/cubits/search_cubit/search_cubit.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late double maxPrice;
  late bool organicOnly;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SearchCubit>();
    maxPrice = cubit.maxPrice;
    organicOnly = cubit.organicOnly;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'تصفية',
                style: AppTextStyles.bold16,
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, color: Color(0xFF949D9E)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('السعر: حتى ${maxPrice.toInt()} جنيه', style: AppTextStyles.bold16),
          Slider(
            value: maxPrice,
            min: 0,
            max: 1000,
            divisions: 20,
            activeColor: AppColors.primaryColor,
            label: maxPrice.round().toString(),
            onChanged: (value) {
              setState(() {
                maxPrice = value;
              });
            },
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('منتجات عضوية فقط', style: AppTextStyles.bold16),
              Switch(
                value: organicOnly,
                activeColor: AppColors.primaryColor,
                onChanged: (value) {
                  setState(() {
                    organicOnly = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 32),
          CustomButton(
            text: 'تطبيق',
            onPressed: () {
              context.read<SearchCubit>().applyFilters(
                    organic: organicOnly,
                    maxPrice: maxPrice,
                  );
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
