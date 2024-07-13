// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:spotify/domain/entities/song/song.dart';

abstract class NewsSongsState {}

class NewsSongsLoading extends NewsSongsState {}

class NewsSongsLoaded extends NewsSongsState {
  final List<SongEntity> songs;
  NewsSongsLoaded({
    required this.songs,
  });
}

class NewsSongsLoadFailure extends NewsSongsState {}
