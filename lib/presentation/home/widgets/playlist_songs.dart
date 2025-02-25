import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:refresh_flutter/common/helpers/is_dark_mode.dart';
import 'package:refresh_flutter/core/configs/assets/app_vectors.dart';
import 'package:refresh_flutter/core/configs/theme/app_colors.dart';
import 'package:refresh_flutter/domain/entities/song/song.dart';
import 'package:refresh_flutter/presentation/home/bloc/playlist_cubit.dart';
import 'package:refresh_flutter/presentation/home/bloc/playlist_state.dart';

class PlaylistSongs extends StatelessWidget {
  const PlaylistSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlaylistCubit()..fetchPlaylist(),
      child: BlocBuilder<PlaylistCubit, PlaylistState>(
        builder: (context, state) {
          if (state is PlaylistLoading) {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          } else if (state is PlaylistLoaded) {
            return Column(
              children: [
                _buildPlaylistHeader(context),
                const SizedBox(height: 20),
                _songs(state.songs, context),
              ],
            );
          } else if (state is PlaylistError) {
            print("Error: ${state.message}");
            return Center(
              child: Text("Error: ${state.message}"),
            );
          }
          return const Center(
            child: Text("No songs available"),
          );
        },
      ),
    );
  }

  Widget _songs(List<SongEntity> songs, BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        print(songs[index].title);
        return _playListSongs(context, songs[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemCount: songs.length,
    );
  }

  Widget _playListSongs(BuildContext context, SongEntity song) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _playIcon(context),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                song.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                song.artist,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 2,
          child: Text(
            song.duration.toString(),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: context.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
        SvgPicture.asset(
          AppVectors.heartLogo,
          fit: BoxFit.none,
          colorFilter: context.isDarkMode
              ? const ColorFilter.mode(Color(0xFF959595), BlendMode.srcIn)
              : const ColorFilter.mode(Colors.black, BlendMode.srcIn),
        ),
      ],
    );
  }

  Widget _buildPlaylistHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Playlist',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: context.isDarkMode ? Colors.white : Colors.black,
            )),
        Text(
          'See More',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.normal,
            color: context.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _playIcon(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            context.isDarkMode ? AppColors.darkGrey : const Color(0xFFE6E6E6),
      ),
      child: SvgPicture.asset(
        AppVectors.playLogo,
        fit: BoxFit.none,
        colorFilter: context.isDarkMode
            ? const ColorFilter.mode(Color(0xFF959595), BlendMode.srcIn)
            : const ColorFilter.mode(Colors.black, BlendMode.srcIn),
      ),
    );
  }
}
