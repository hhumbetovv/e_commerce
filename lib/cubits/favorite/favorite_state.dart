part of 'favorite_cubit.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object?> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<String> favoriteIds;

  const FavoriteLoaded(this.favoriteIds);

  @override
  List<Object?> get props => favoriteIds;
}
