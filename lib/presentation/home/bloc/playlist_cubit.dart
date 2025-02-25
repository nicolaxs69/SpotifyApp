import 'package:bloc/bloc.dart';
import 'package:refresh_flutter/domain/usecases/song/fetch_playlist.dart';
import 'package:refresh_flutter/presentation/home/bloc/playlist_state.dart';
import 'package:refresh_flutter/service_locator.dart';

class PlaylistCubit extends Cubit<PlaylistState> {
  PlaylistCubit() : super(PlaylistLoading());
  Future<void> fetchPlaylist() async {
    emit(PlaylistLoading());
    try {
      final returnedPlaylist =
          await serviceLocator<FetchPlaylistUseCase>().call(1);
      returnedPlaylist.fold(
        (error) => emit(PlaylistError(error)),
        (data) => emit(PlaylistLoaded(songs: data)),
      );
    } catch (e) {
      emit(PlaylistError(e.toString()));
    }
  }
}
