import 'package:spotify/domain/entities/song/song.dart';

abstract class FavoriteSongsState {}

class FavoriteSongsLoading extends FavoriteSongsState {}

class FavoriteSongsLoaded extends FavoriteSongsState {
  final List<SongEntity> songsEntities;
  FavoriteSongsLoaded({
    required this.songsEntities,
  });
}

class FavoriteSongsFailure extends FavoriteSongsState {}
