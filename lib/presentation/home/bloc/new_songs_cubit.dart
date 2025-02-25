import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:refresh_flutter/domain/entities/song/song.dart';
import 'package:refresh_flutter/domain/usecases/song/fetch_songs.dart';
import 'package:refresh_flutter/service_locator.dart';

part 'new_songs_state.dart';

class NewSongsCubit extends Cubit<NewSongsState> {
  NewSongsCubit() : super(NewSongsLoading());

  Future<void> fetchSongs() async {
    emit(NewSongsLoading());
    try {
      final returnedSongs = await serviceLocator<FetchSongsUseCase>().call(1);
      returnedSongs.fold(
        (error) => emit(NewSongsError(error)),
        (data) => emit(NewSongsLoaded(songs: data)),
      );
    } catch (e) {
      emit(NewSongsError(e.toString()));
    }
  }
}
