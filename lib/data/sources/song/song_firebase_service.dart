import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/data/models/song/song.dart';
import 'package:spotify/domain/entities/song/song.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavouriteSongs(String songID);
  Future<bool> isFavoriteSong(String songID);
}

class SongFirebaseServiceImpl extends SongFirebaseService {
  @override
  Future<Either> getNewsSongs() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .limit(3)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } catch (e) {
      return const Left("An Error occurred.");
    }
  }

  @override
  Future<Either> getPlayList() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } catch (e) {
      return const Left("An Error occurred.");
    }
  }

  @override
  Future<Either> addOrRemoveFavouriteSongs(String songID) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      late bool isFavorite;
      var user = firebaseAuth.currentUser;
      String userID = user!.uid;
      QuerySnapshot favouriteSongs = await firebaseFirestore
          .collection("Users")
          .doc(userID)
          .collection('Favorites')
          .where('songId', isEqualTo: songID)
          .get();

      if (favouriteSongs.docs.isNotEmpty) {
        await favouriteSongs.docs.first.reference.delete();
        isFavorite = false;
      } else {
        await firebaseFirestore
            .collection('Users')
            .doc(userID)
            .collection('Favorites')
            .add({'songId': songID, 'addedDate': Timestamp.now()});
        isFavorite = true;
      }
      return Right(isFavorite);
    } catch (e) {
      return const Left("An error occured");
    }
  }

  @override
  Future<bool> isFavoriteSong(String songID) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = firebaseAuth.currentUser;
      String userID = user!.uid;
      QuerySnapshot favouriteSongs = await firebaseFirestore
          .collection("Users")
          .doc(userID)
          .collection('Favorites')
          .where('songId', isEqualTo: songID)
          .get();

      if (favouriteSongs.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
