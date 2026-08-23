import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/utils/app_colors.dart';
import 'package:fruts_e_commerce/core/utils/app_text_styles.dart';
import 'package:fruts_e_commerce/features/search/presentation/cubits/search_cubit/search_cubit.dart';

class SortBottomSheet extends StatelessWidget {
  const SortBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    final currentSort = cubit.currentSort;

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
                'ترتيب حسب',
                style: AppTextStyles.bold16,
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, color: Color(0xFF949D9E)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSortOption(
            context,
            title: 'السعر: من الأقل للأعلى',
            option: SortOption.priceLowToHigh,
            currentSort: currentSort,
            onTap: () {
              cubit.applySorting(SortOption.priceLowToHigh);
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 16),
          _buildSortOption(
            context,
            title: 'السعر: من الأعلى للأقل',
            option: SortOption.priceHighToLow,
            currentSort: currentSort,
            onTap: () {
              cubit.applySorting(SortOption.priceHighToLow);
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 16),
          _buildSortOption(
            context,
            title: 'الاسم: أ-ي',
            option: SortOption.nameAZ,
            currentSort: currentSort,
            onTap: () {
              cubit.applySorting(SortOption.nameAZ);
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 16),
          _buildSortOption(
            context,
            title: 'افتراضي (بدون ترتيب)',
            option: SortOption.none,
            currentSort: currentSort,
            onTap: () {
              cubit.applySorting(SortOption.none);
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSortOption(
    BuildContext context, {
    required String title,
    required SortOption option,
    required SortOption currentSort,
    required VoidCallback onTap,
  }) {
    final isSelected = option == currentSort;
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.bold16.copyWith(
              color: isSelected ? AppColors.primaryColor : const Color(0xFF4E5556),
            ),
          ),
          if (isSelected)
            const Icon(Icons.check, color: AppColors.primaryColor),
        ],
      ),
    );
  }
}
