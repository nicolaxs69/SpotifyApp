import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:refresh_flutter/common/helpers/is_dark_mode.dart';
import 'package:refresh_flutter/common/widgets/appbar/app_bar.dart';
import 'package:refresh_flutter/core/configs/assets/app_vectors.dart';
import 'package:refresh_flutter/core/configs/constants/app_urls.dart';
import 'package:refresh_flutter/domain/entities/song/song.dart';
import 'package:refresh_flutter/presentation/song_player/bloc/song_player_cubit.dart';

class SongPlayerView extends StatelessWidget {
  final SongEntity songEntity;
  const SongPlayerView({super.key, required this.songEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: Text(
          "Now Playing",
          style: TextStyle(
              color: context.isDarkMode ? Colors.white : Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        action: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.more_vert,
            color: context.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => SongPlayerCubit()
          ..loadSong(
              '${AppUrls.songFirebaseStorage}${songEntity.title} - ${songEntity.artist}.mp3?${AppUrls.mediaAlt}'),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Center(
              child: Column(
                children: [
                  _songCover(context),
                  const SizedBox(height: 20),
                  _songDetails(context),
                  const SizedBox(height: 30),
                  _songPlayer(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              '${AppUrls.coverFirebaseStorage}${songEntity.title} - ${songEntity.artist}.jpg?${AppUrls.mediaAlt}',
            ),
          )),
    );
  }

  Widget _songDetails(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              songEntity.title,
              style: TextStyle(
                  color: context.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              songEntity.artist,
              style: TextStyle(
                  color: context.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        SvgPicture.asset(
          AppVectors.heartEmptyLogo,
          height: 24,
          width: 24,
        ),
      ],
    );
  }

  Widget _songPlayer(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return const CircularProgressIndicator();
        } else if (state is SongPlayerLoaded) {
          return Column(
            children: [
              Slider(
                  value: context
                      .read<SongPlayerCubit>()
                      .songPosition
                      .inSeconds
                      .toDouble(),
                  min: 0,
                  max: context
                      .read<SongPlayerCubit>()
                      .songPosition
                      .inSeconds
                      .toDouble(),
                  onChanged: (value) {}),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
