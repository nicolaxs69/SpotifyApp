import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';
import 'package:refresh_flutter/domain/entities/song/song.dart';

part 'song_player_state.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongPlayerCubit() : super(SongPlayerLoading()) {
    audioPlayer.positionStream.listen(
      (position) {
        songPosition = position;
        updateSongPlayer();
      },
    );

      audioPlayer.durationStream.listen(
      (duration) {
        songDuration = duration!; 
      },
    );
  }

  void updateSongPlayer(){
    emit(
      SongPlayerLoaded()
    );
  }

  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> loadSong(String url) async {
    try {
      await audioPlayer.setUrl(url);
      emit(SongPlayerLoaded());
    } catch (e) {
      print("Error loading the song: $e");
      emit(SongPlayerError(e.toString()));
    }
  }

  void playOrPause(String url) {
    if (audioPlayer.playing) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
    emit(SongPlayerLoaded());
  }

  @override
  Future<void> close(){
    audioPlayer.dispose();
    return super.close();
  }
}
