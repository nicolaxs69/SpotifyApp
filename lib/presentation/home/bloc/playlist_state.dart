import 'package:flutter/material.dart';
import 'package:refresh_flutter/domain/entities/song/song.dart';

@immutable
sealed class PlaylistState {}

final class PlaylistLoading extends PlaylistState {}

final class PlaylistLoaded extends PlaylistState {
  final List<SongEntity> songs;

  PlaylistLoaded({required this.songs});
}

final class PlaylistError extends PlaylistState {
  final String message;

  PlaylistError(this.message);
}
