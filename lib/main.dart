import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:refresh_flutter/core/configs/theme/app_theme.dart';
import 'package:refresh_flutter/firebase_options.dart';
import 'package:refresh_flutter/presentation/choose_mode/bloc/theme_cubit.dart';
import 'package:refresh_flutter/presentation/splash/views/splash_view.dart';
import 'package:refresh_flutter/service_locator.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeDependencies();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) => MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: mode,
          debugShowCheckedModeBanner: false,
          home: const Splashview(),
        ),
      ),
    );
  }
}

class WaveDemoHomePage extends StatefulWidget {
  const WaveDemoHomePage({super.key, this.title});

  final String? title;

  @override
  _WaveDemoHomePageState createState() => _WaveDemoHomePageState();
}

class _WaveDemoHomePageState extends State<WaveDemoHomePage> {
  _buildCard({
    required Config config,
    Color? backgroundColor = Colors.transparent,
    DecorationImage? backgroundImage,
    double height = 300.0,
  }) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Card(
        elevation: 12.0,
        margin: EdgeInsets.only(
            right: marginHorizontal, left: marginHorizontal, bottom: 16.0),
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        child: WaveWidget(
          config: config,
          backgroundColor: backgroundColor,
          backgroundImage: backgroundImage,
          size: const Size(double.infinity, double.infinity),
          waveAmplitude: 10,
        ),
      ),
    );
  }

  double marginHorizontal = 16.0;

  @override
  Widget build(BuildContext context) {
    marginHorizontal = 16.0 +
        (MediaQuery.of(context).size.width > 512
            ? (MediaQuery.of(context).size.width - 512) / 2
            : 0);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wave Demo"),
        elevation: 2.0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'icons/ic_github.png',
              package: 'web3_icons',
              width: 32.0,
              height: 32.0,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildCard(
                  config: CustomConfig(
                    colors: [
                      const Color(0xFF00BBF9).withOpacity(0.3),
                    ],
                    durations: [
                      120000, // 2 minutes
                    ],
                    heightPercentages: [
                      0.65,
                    ],
                  ),
                  backgroundColor: Colors.blue[600],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
