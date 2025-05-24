import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:refresh_flutter/common/helpers/is_dark_mode.dart';
import 'package:refresh_flutter/common/widgets/appbar/app_bar.dart';
import 'package:refresh_flutter/core/configs/assets/app_images.dart';
import 'package:refresh_flutter/core/configs/assets/app_vectors.dart';
import 'package:refresh_flutter/core/configs/theme/app_colors.dart';
import 'package:refresh_flutter/presentation/home/widgets/new_songs.dart';
import 'package:refresh_flutter/presentation/home/widgets/playlist_songs.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        hideBack: true,
        title: SvgPicture.asset(
          width: 108,
          height: 33,
          AppVectors.logo,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _albumCover(),
              _tabs(),
              SizedBox(
                height: 260,
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    NewSongs(),
                    Center(child: Text('Video Content Coming Soon')),
                    Center(child: Text('Artist Content Coming Soon')),
                    Center(child: Text('Podcast Content Coming Soon')),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const PlaylistSongs(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _albumCover() {
    return Center(
      child: SizedBox(
        height: 200,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                AppVectors.albumHomeLogo,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  AppImages.billieHomeBg,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabs() {
    return TabBar(
      tabAlignment: TabAlignment.start,
      padding: const EdgeInsets.symmetric(vertical: 20),
      controller: _tabController,
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      indicatorColor: AppColors.primary,
      indicatorSize: TabBarIndicatorSize.label,
      dividerColor: Colors.transparent,
      isScrollable: true,
      tabs: const [
        Text("News",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        Text("Video",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        Text("Artist",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        Text("Podcast",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
