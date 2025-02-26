import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:refresh_flutter/common/helpers/is_dark_mode.dart';
import 'package:refresh_flutter/core/configs/assets/app_vectors.dart';
import 'package:refresh_flutter/core/configs/constants/app_urls.dart';
import 'package:refresh_flutter/core/configs/theme/app_colors.dart';
import 'package:refresh_flutter/domain/entities/song/song.dart';
import 'package:refresh_flutter/presentation/home/bloc/new_songs_cubit.dart';
import 'package:refresh_flutter/presentation/song_player/views/song_player.dart';

class NewSongs extends StatelessWidget {
  const NewSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NewSongsCubit()..fetchSongs(),
        child: SizedBox(
          height: 200,
          child: BlocBuilder<NewSongsCubit, NewSongsState>(
            builder: (context, state) {
              if (state is NewSongsLoading) {
                return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                );
              } else if (state is NewSongsLoaded) {
                return _songs(state.songs, context);
              } else if (state is NewSongsError) {
                print("Error: ${state.message}");
                return Center(child: Text("Error: ${state.message}"));
              }
              return const Center(
                  child: Text("No songs available")); // Default case
            },
          ),
        ));
  }
}

Widget _songs(List<SongEntity> songs, BuildContext context) {
  const itemWidth = 147.0;
  const double itemHeight = 300.0;

  return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        print(songs[index].title);
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => SongPlayerView(
                  songEntity: songs[index],
                ),
              ),
            );
          },
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: itemWidth,
              maxHeight: itemHeight,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: itemWidth,
                  height: 185,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        '${AppUrls.coverFirebaseStorage}${songs[index].title} - ${songs[index].artist}.jpg?${AppUrls.mediaAlt}',
                      ),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 35,
                      height: 35,
                      transform: Matrix4.translationValues(-5, 15, 0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.isDarkMode
                            ? AppColors.darkGrey
                            : const Color(0xFFE6E6E6),
                      ),
                      child: SvgPicture.asset(
                        AppVectors.playLogo,
                        fit: BoxFit.none,
                        colorFilter: context.isDarkMode
                            ? const ColorFilter.mode(
                                Color(0xFF959595), BlendMode.srcIn)
                            : const ColorFilter.mode(
                                Colors.black, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 13),
                Text(
                  songs[index].title,
                  style: TextStyle(
                    color: context.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                ),
                const SizedBox(height: 4),
                Text(
                  songs[index].artist,
                  style: TextStyle(
                    color: context.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 14),
      itemCount: songs.length);
}
