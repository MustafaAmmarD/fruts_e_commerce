import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fruts_e_commerce/core/utils/app_colors.dart';
import 'package:fruts_e_commerce/core/utils/app_text_styles.dart';
import 'package:fruts_e_commerce/core/widgets/search_text_field.dart';
import 'package:fruts_e_commerce/core/services/shared_preferences_singleton.dart';
import 'package:fruts_e_commerce/features/search/presentation/cubits/search_cubit/search_cubit.dart';
import 'package:fruts_e_commerce/features/home/presentation/views/widgets/products_grid_view.dart';
import 'package:fruts_e_commerce/features/home/presentation/views/widgets/custom_error_widget.dart';
import 'package:fruts_e_commerce/features/search/presentation/views/widgets/filter_bottom_sheet.dart';
import 'package:fruts_e_commerce/features/search/presentation/views/widgets/sort_bottom_sheet.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  List<String> recentSearches = [];
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _loadRecentSearches();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadRecentSearches() {
    setState(() {
      recentSearches = Prefs.getStringList('recent_searches');
    });
  }

  void _saveRecentSearches() {
    Prefs.setStringList('recent_searches', recentSearches);
  }

  void _addSearch(String query) {
    if (query.trim().isEmpty) return;
    setState(() {
      if (recentSearches.contains(query)) {
        recentSearches.remove(query);
      }
      recentSearches.insert(0, query);
      if (recentSearches.length > 10) {
        recentSearches = recentSearches.sublist(0, 10);
      }
      _saveRecentSearches();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios_new, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Hero(
                  tag: 'search_field',
                  child: Material(
                    type: MaterialType.transparency,
                    child: SearchTextField(
                      controller: _searchController,
                      onChanged: (value) {
                        context.read<SearchCubit>().searchProducts(value);
                      },
                      onSubmitted: (value) {
                        _addSearch(value);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildFilterSortButton(
                context,
                icon: Icons.sort,
                label: 'ترتيب',
                onTap: () {
                  final cubit = context.read<SearchCubit>();
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => BlocProvider.value(
                      value: cubit,
                      child: const SortBottomSheet(),
                    ),
                  );
                },
              ),
              const SizedBox(width: 12),
              _buildFilterSortButton(
                context,
                icon: Icons.filter_list,
                label: 'تصفية',
                onTap: () {
                  final cubit = context.read<SearchCubit>();
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => BlocProvider.value(
                      value: cubit,
                      child: const FilterBottomSheet(),
                    ),
                  );
                },
              ),
              const Spacer(),
              BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  final cubit = context.read<SearchCubit>();
                  final hasFilters = cubit.organicOnly || cubit.maxPrice < 1000.0 || cubit.currentSort != SortOption.none;
                  if (hasFilters) {
                    return GestureDetector(
                      onTap: () {
                        cubit.clearFilters();
                      },
                      child: Text(
                        'مسح الفلاتر',
                        style: AppTextStyles.regular13.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (recentSearches.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'البحث مؤخرا',
                  style: AppTextStyles.bold13,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      recentSearches.clear();
                      _saveRecentSearches();
                    });
                  },
                  child: Text(
                    'مسح',
                    style: AppTextStyles.regular13.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: recentSearches
                  .map((search) => _buildRecentSearchItem(search))
                  .toList(),
            ),
          ],
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchSuccess) {
                  if (state.products.isEmpty) {
                    return const Center(child: Text('لا توجد منتجات مطابقة'));
                  }
                  return AnimationLimiter(
                    child: CustomScrollView(
                      slivers: [
                        ProductsGridView(products: state.products),
                      ],
                    ),
                  );
                } else if (state is SearchFailure) {
                  return CustomErrorWidget(text: state.errMessage);
                } else if (state is SearchLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const SizedBox(); // Initial state: show nothing extra
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSearchItem(String text) {
    return GestureDetector(
      onTap: () {
        _searchController.text = text;
        context.read<SearchCubit>().searchProducts(text);
        _addSearch(text);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F5F7),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: AppTextStyles.regular13.copyWith(
                color: const Color(0xFF4E5556),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                setState(() {
                  recentSearches.remove(text);
                  _saveRecentSearches();
                });
              },
              child: const Icon(
                Icons.close,
                size: 14,
                color: Color(0xFF949D9E),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildFilterSortButton(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFF1F1F5)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: const Color(0xFF4E5556)),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTextStyles.bold13.copyWith(
                color: const Color(0xFF4E5556),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
