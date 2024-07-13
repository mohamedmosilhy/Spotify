import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify/domain/entities/song/song.dart';

class SongModel {
  String? title;
  String? artist;
  num? duration;
  Timestamp? releaseDate;

  SongModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
  });

  SongModel.fromJson(Map<String, dynamic> data) {
    title = data['title'];
    artist = data['artist'];
    duration = data['duration'];
    releaseDate = data['releaseDate'];

    // Print values from JSON
    print('Title from JSON: $title');
    print('Artist from JSON: $artist');
    print('Duration from JSON: $duration');
    print('Release Date from JSON: $releaseDate');
  }

  @override
  String toString() {
    return 'SongModel{title: $title, artist: $artist, duration: $duration, releaseDate: $releaseDate}';
  }
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    // Print values in toEntity
    print('Title in toEntity: $title');
    print('Artist in toEntity: $artist');
    print('Duration in toEntity: $duration');
    print('Release Date in toEntity: $releaseDate');

    return SongEntity(
      title: title!,
      artist: artist!,
      duration: duration!,
      releaseDate: releaseDate!,
    );
  }
}
