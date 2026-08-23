import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/services/database_service.dart';
import 'package:fruts_e_commerce/core/services/shared_preferences_singleton.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this.databaseService) : super(FavoritesInitial()) {
    _loadLocalFavorites();
    fetchCloudFavorites();
  }

  final DatabaseService databaseService;
  List<String> favoriteCodes = [];

  Future<void> fetchCloudFavorites() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userData = await databaseService.getData(
          path: 'users',
          documentId: user.uid,
        );
        if (userData is Map<String, dynamic> && userData['favorites'] != null) {
          final cloudFavorites = List<String>.from(userData['favorites']);
          
          final localFavorites = Prefs.getStringList('favorites_list');
          final Set<String> merged = {...localFavorites, ...cloudFavorites};
          
          favoriteCodes = merged.toList();
          Prefs.setStringList('favorites_list', favoriteCodes);
          
          if (localFavorites.isNotEmpty && localFavorites.length != cloudFavorites.length) {
            await databaseService.updateData(
              path: 'users',
              documentId: user.uid,
              data: {'favorites': favoriteCodes},
            );
          }
          
          emit(FavoritesUpdated(List.from(favoriteCodes)));
        }
      }
    } catch (e) {
      _loadLocalFavorites();
    }
  }

  void _loadLocalFavorites() {
    favoriteCodes = Prefs.getStringList('favorites_list');
    emit(FavoritesUpdated(List.from(favoriteCodes)));
  }

  Future<void> toggleFavorite(String productCode) async {
    if (favoriteCodes.contains(productCode)) {
      favoriteCodes.remove(productCode);
    } else {
      favoriteCodes.add(productCode);
    }
    
    Prefs.setStringList('favorites_list', favoriteCodes);
    emit(FavoritesUpdated(List.from(favoriteCodes)));

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await databaseService.updateData(
          path: 'users',
          documentId: user.uid,
          data: {'favorites': favoriteCodes},
        );
      } catch (e) {
        // Silently fail cloud update if network is down
      }
    }
  }

  bool isFavorite(String productCode) {
    return favoriteCodes.contains(productCode);
  }
}
