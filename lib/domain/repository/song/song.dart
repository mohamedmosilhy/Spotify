import 'package:dartz/dartz.dart';

abstract class SongRepository {
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavouriteSongs(String songID);
  Future<bool> isFavouriteSong(String songID);
}
