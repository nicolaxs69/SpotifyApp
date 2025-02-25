part of 'new_songs_cubit.dart';

@immutable
sealed class NewSongsState {}

final class NewSongsLoading extends NewSongsState {}

final class NewSongsLoaded extends NewSongsState {
  final List<SongEntity> songs;

  NewSongsLoaded({required this.songs});
}

final class NewSongsError extends NewSongsState {
  final String message;

  NewSongsError(this.message);
}
