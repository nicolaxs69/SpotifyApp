import 'package:dartz/dartz.dart';

abstract class SongRepository {
  Future<Either> fetchSongs();
  Future<Either> fetchPlaylist();
}
