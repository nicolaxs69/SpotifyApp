import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:refresh_flutter/data/models/song/song.dart';
import 'package:refresh_flutter/domain/entities/song/song.dart';

abstract class SongFirebaseService {
  Future<Either> fetchSongs();
}

class SongFirebaseServiceImpl implements SongFirebaseService {
  @override
  Future<Either> fetchSongs() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .limit(3)
          .get();

      for (var doc in data.docs) {
        var songModel = SongModel.fromJson(doc.data());
        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } catch (e) {
      print("Error fetching songs: $e");
      return const Left("An error occurred, please try again later");
    }
  }
}
