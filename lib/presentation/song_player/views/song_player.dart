import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:refresh_flutter/common/helpers/is_dark_mode.dart';
import 'package:refresh_flutter/common/widgets/appbar/app_bar.dart';
import 'package:refresh_flutter/core/configs/assets/app_vectors.dart';
import 'package:refresh_flutter/core/configs/constants/app_urls.dart';
import 'package:refresh_flutter/core/configs/theme/app_colors.dart';
import 'package:refresh_flutter/domain/entities/song/song.dart';
import 'package:refresh_flutter/presentation/song_player/bloc/song_player_cubit.dart';

class SongPlayerView extends StatefulWidget {
  final SongEntity songEntity;
  const SongPlayerView({super.key, required this.songEntity});

  @override
  _SongPlayerViewState createState() => _SongPlayerViewState();
}

class _SongPlayerViewState extends State<SongPlayerView> {
  late final SongPlayerCubit _songPlayerCubit;
  late final String songUrl;

  @override
  void initState() {
    super.initState();

    // Intialize the cubit
    _songPlayerCubit = SongPlayerCubit();

    songUrl =
        '${AppUrls.songFirebaseStorage}${widget.songEntity.title} - ${widget.songEntity.artist}.mp3?${AppUrls.mediaAlt}';

    // Play the song as soon as the view is loaded
    _songPlayerCubit.loadSong(songUrl);
    _songPlayerCubit.playOrPause(songUrl);
  }

  @override
  void dispose() {
    _songPlayerCubit.close();
    super.dispose();
  }

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
      body: BlocProvider.value(
        value: _songPlayerCubit,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Builder(
            builder: (context) {
              return Column(
                children: [
                  _songCover(context),
                  const SizedBox(height: 20),
                  _songDetails(context),
                  const SizedBox(height: 30),
                  _songPlayer(context, songUrl),
                ],
              );
            },
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
              '${AppUrls.coverFirebaseStorage}${widget.songEntity.title} - ${widget.songEntity.artist}.jpg?${AppUrls.mediaAlt}',
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
              widget.songEntity.title,
              style: TextStyle(
                  color: context.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              widget.songEntity.artist,
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

  Widget _songPlayer(BuildContext context, String songUrl) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return const CircularProgressIndicator();
        } else if (state is SongPlayerLoaded) {
          return Column(
            children: [
              _progressSlider(context),
              const SizedBox(height: 20),
              _timeDisplay(context),
              const SizedBox(height: 40),
              _buildPlayerControls(context, songUrl),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _progressSlider(BuildContext context) {
    return Slider(
      value: context.read<SongPlayerCubit>().songPosition.inSeconds.toDouble(),
      min: 0,
      max: context.read<SongPlayerCubit>().songDuration.inSeconds.toDouble(),
      onChanged: (value) {},
      activeColor: Theme.of(context).primaryColor,
      inactiveColor: Theme.of(context).disabledColor,
    );
  }

  Widget _timeDisplay(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          formatDuration(context.read<SongPlayerCubit>().songPosition),
          style: TextStyle(
              color: context.isDarkMode ? Colors.white : Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.normal),
        ),
        Text(
          formatDuration(context.read<SongPlayerCubit>().songDuration),
          style: TextStyle(
              color: context.isDarkMode ? Colors.white : Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.normal),
        ),
      ],
    );
  }

  Widget _buildPlayerControls(BuildContext context, String songUrl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildControlButton(
          context,
          iconAsset: AppVectors.repeatLogo,
          onTap: () {},
        ),
        const SizedBox(width: 20),
        _buildControlButton(
          context,
          iconAsset: AppVectors.playPreviousLogo,
          onTap: () {},
        ),
        const SizedBox(width: 20),
        _buildPlayPauseButton(context, songUrl),
        const SizedBox(width: 20),
        _buildControlButton(
          context,
          iconAsset: AppVectors.playNextLogo,
          onTap: () {},
        ),
        const SizedBox(width: 20),
        _buildControlButton(
          context,
          iconAsset: AppVectors.shuffleLogo,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildControlButton(
    BuildContext context, {
    required String iconAsset,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        iconAsset,
        height: 30,
        width: 30,
        color: context.isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _buildPlayPauseButton(BuildContext context, String songUrl) {
    return GestureDetector(
      onTap: () {
        context.read<SongPlayerCubit>().playOrPause(songUrl);
      },
      child: Container(
        height: 72,
        width: 72,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary,
        ),
        child: Center(
          child: SvgPicture.asset(
            context.read<SongPlayerCubit>().audioPlayer.playing
                ? AppVectors.pauseLogo
                : AppVectors.playLogo,
            height: 30,
            width: 30,
            fit: BoxFit.contain,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
