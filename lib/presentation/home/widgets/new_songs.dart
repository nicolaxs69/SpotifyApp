import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refresh_flutter/core/configs/constants/app_urls.dart';
import 'package:refresh_flutter/core/configs/theme/app_colors.dart';
import 'package:refresh_flutter/domain/entities/song/song.dart';
import 'package:refresh_flutter/presentation/home/bloc/new_songs_cubit.dart';

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
                return _songs(state.songs);
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

Widget _songs(List<SongEntity> songs) {
  return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        print(songs[index].title);
        return SizedBox(
          height: 200,
          child: Column(
            children: [
              Container(
                width: 147,
                height: 185,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      AppUrls.firebaseStorage +
                          songs[index].title +
                          ' - ' +
                          songs[index].artist +
                          '.jpg?' +
                          AppUrls.mediaAlt,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 14),
      itemCount: songs.length);
}
