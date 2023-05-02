import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../enums/cache_items.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  Future<void> getFavoriteProducts() async {
    emit(FavoriteLoading());
    List<String> favoriteIds = CacheItems.favorites.getStringList;
    emit(FavoriteLoaded(favoriteIds));
  }

  Future<void> addProduct(String id) async {
    emit(FavoriteLoading());
    List<String> favoriteIds = CacheItems.favorites.getStringList;
    favoriteIds.add(id);
    CacheItems.favorites.setStringList(favoriteIds);
    emit(FavoriteLoaded(favoriteIds));
  }

  Future<void> removeProduct(String id) async {
    emit(FavoriteLoading());
    List<String> favoriteIds = CacheItems.favorites.getStringList;
    favoriteIds.remove(id);
    CacheItems.favorites.setStringList(favoriteIds);

    emit(FavoriteLoaded(favoriteIds));
  }

  Future<void> toggleProduct(String id) async {
    emit(FavoriteLoading());
    List<String> favoriteIds = CacheItems.favorites.getStringList;
    if (favoriteIds.contains(id)) {
      favoriteIds.remove(id);
    } else {
      favoriteIds.add(id);
    }
    CacheItems.favorites.setStringList(favoriteIds);

    emit(FavoriteLoaded(favoriteIds));
  }
}
