import 'package:bloc/bloc.dart';
import 'package:e_commerce/enums/cache_items.dart';
import 'package:equatable/equatable.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  void getFavoriteProducts() {
    emit(FavoriteLoading());
    List<String> favoriteIds = CacheItems.favorites.getStringList;
    emit(FavoriteLoaded(favoriteIds));
  }

  void addProduct(String id) {
    emit(FavoriteLoading());
    List<String> favoriteIds = CacheItems.favorites.getStringList;
    favoriteIds.add(id);
    CacheItems.favorites.setStringList(favoriteIds);
    emit(FavoriteLoaded(favoriteIds));
  }

  void removeProduct(String id) {
    emit(FavoriteLoading());
    List<String> favoriteIds = CacheItems.favorites.getStringList;
    favoriteIds.remove(id);
    CacheItems.favorites.setStringList(favoriteIds);

    emit(FavoriteLoaded(favoriteIds));
  }

  void toggleProduct(String id) {
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
