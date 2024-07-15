import 'package:dartz/dartz.dart';
import 'package:spotify/data/sources/song/song_firebase_service.dart';
import 'package:spotify/domain/repository/song/song.dart';
import 'package:spotify/service_locator.dart';

class SongRepositoryImpl extends SongRepository {
  @override
  Future<Either> getNewsSongs() async {
    return await serviceLocator<SongFirebaseService>().getNewsSongs();
  }

  @override
  Future<Either> getPlayList() async {
    return await serviceLocator<SongFirebaseService>().getPlayList();
  }

  @override
  Future<Either> addOrRemoveFavouriteSongs(String songID) async {
    return await serviceLocator<SongFirebaseService>()
        .addOrRemoveFavouriteSongs(songID);
  }

  @override
  Future<bool> isFavouriteSong(String songID) async {
    return await serviceLocator<SongFirebaseService>().isFavoriteSong(songID);
  }

  @override
  Future<Either> getUserFavoriteSongs() async {
    return await serviceLocator<SongFirebaseService>().getUserFavoriteSongs();
  }
}
