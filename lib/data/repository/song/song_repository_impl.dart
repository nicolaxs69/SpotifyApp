import 'package:dartz/dartz.dart';
import 'package:refresh_flutter/data/sources/song/song_firebase_service.dart';
import 'package:refresh_flutter/domain/repository/song/song.dart';
import 'package:refresh_flutter/service_locator.dart';

class SongRepositoryImpl extends SongRepository {
  @override
  Future<Either> fetchSongs() async{
    return await serviceLocator<SongFirebaseService>().fetchSongs();
  }
}