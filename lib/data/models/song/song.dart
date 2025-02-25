import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:refresh_flutter/domain/entities/song/song.dart';

class SongModel {
  late String title;
  late String artist;
  late Timestamp releaseDate;
  late num duration;

  SongModel({
    required this.title,
    required this.artist,
    required this.releaseDate,
    required this.duration,
  });

  SongModel.fromJson(Map<String, dynamic> data) {
    title = data['title'] as String;
    artist = data['artist'] as String;
    releaseDate = data['releaseDate'] as Timestamp;
    if (data['duration'] is String) {
      duration = double.parse(data['duration'] as String);
    } else {
      duration = data['duration'] as num;
    }
  }
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      title: title,
      artist: artist,
      releaseDate: releaseDate,
      duration: duration,
    );
  }
}
