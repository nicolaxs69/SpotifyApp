import 'package:dartz/dartz.dart';
import 'package:refresh_flutter/core/usecase/usecase.dart';
import 'package:refresh_flutter/domain/repository/song/song.dart';
import 'package:refresh_flutter/service_locator.dart';

class FetchSongsUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call(params) async {
    return await serviceLocator<SongRepository>().fetchSongs();
  }
}
