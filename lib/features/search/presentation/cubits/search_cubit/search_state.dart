part of 'search_cubit.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<ProductEntity> products;

  SearchSuccess(this.products);
}

class SearchFailure extends SearchState {
  final String errMessage;

  SearchFailure(this.errMessage);
}
