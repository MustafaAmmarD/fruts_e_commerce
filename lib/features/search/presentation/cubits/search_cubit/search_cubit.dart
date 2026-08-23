import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/entites/product_entity.dart';
import 'package:fruts_e_commerce/core/repos/products_repo/products_repo.dart';

part 'search_state.dart';

enum SortOption { priceLowToHigh, priceHighToLow, nameAZ, none }

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.productsRepo) : super(SearchInitial());

  final ProductsRepo productsRepo;
  List<ProductEntity> _allProducts = [];
  
  String _currentQuery = '';
  SortOption _currentSort = SortOption.none;
  bool _organicOnly = false;
  double _maxPrice = 1000.0;

  double get maxPrice => _maxPrice;
  bool get organicOnly => _organicOnly;
  SortOption get currentSort => _currentSort;

  Future<void> searchProducts(String query) async {
    _currentQuery = query;
    if (query.trim().isEmpty && _currentSort == SortOption.none && !_organicOnly && _maxPrice == 1000.0) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    if (_allProducts.isEmpty) {
      final result = await productsRepo.getProducts();
      result.fold(
        (failure) => emit(SearchFailure(failure.message)),
        (products) {
          _allProducts = products;
          _applyFiltersAndEmit();
        },
      );
    } else {
      _applyFiltersAndEmit();
    }
  }

  void applySorting(SortOption option) {
    _currentSort = option;
    searchProducts(_currentQuery);
  }

  void applyFilters({bool? organic, double? maxPrice}) {
    if (organic != null) _organicOnly = organic;
    if (maxPrice != null) _maxPrice = maxPrice;
    
    searchProducts(_currentQuery);
  }

  void clearFilters() {
    _organicOnly = false;
    _maxPrice = 1000.0;
    _currentSort = SortOption.none;
    searchProducts(_currentQuery);
  }

  void _applyFiltersAndEmit() {
    // 1. Text Search Filter
    var filtered = _allProducts.where((product) {
      return product.name.toLowerCase().contains(_currentQuery.toLowerCase());
    }).toList();

    // 2. Filters
    if (_organicOnly) {
      filtered = filtered.where((p) => p.isOrganic == true).toList();
    }
    
    filtered = filtered.where((p) => p.price <= _maxPrice).toList();

    // 3. Sorting
    switch (_currentSort) {
      case SortOption.priceLowToHigh:
        filtered.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOption.priceHighToLow:
        filtered.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortOption.nameAZ:
        filtered.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortOption.none:
        break;
    }

    emit(SearchSuccess(filtered));
  }
}
