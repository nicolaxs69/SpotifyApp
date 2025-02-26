part of 'song_player_cubit.dart';

@immutable
sealed class SongPlayerState {}

final class SongPlayerLoading extends SongPlayerState {}

final class SongPlayerLoaded extends SongPlayerState {

  SongPlayerLoaded();
}

final class SongPlayerError extends SongPlayerState {
  final String message;

  SongPlayerError(this.message);
}