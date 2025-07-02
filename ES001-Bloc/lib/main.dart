import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_awesome_namer/bloc/random_word/random_word_cubit.dart';
import 'package:my_awesome_namer/bloc/theme/theme_cubit.dart';
import 'package:my_awesome_namer/navigation/layout_dispatcher.dart';
import 'package:path_provider/path_provider.dart';

/// This method returns the correct directory where to store the data based on the platform.
/// If the app is running on a desktop platform and is in debug mode, it creates a storage folder in the project directory.
/// It's recommendee to put in the .gitignore file the value "DEBUG_STORAGE".
///
Future<Directory> getCorrectDirectory() async {
  final platform = Platform.operatingSystem;

  if (kDebugMode && ['windows', 'linux', 'macos'].contains(platform)) {
    // Get the desktop project directory.
    final projectDirectory = Directory.current;
    // Create a debug storage directory.
    final desktopDebugStorageDirectory = Directory(
      '${projectDirectory.path}/DEBUG_STORAGE',
    );
    // Ensure the directory exists.
    await desktopDebugStorageDirectory.create(recursive: true);
    return desktopDebugStorageDirectory;
  }

  switch (platform) {
    case 'android':
      return getApplicationDocumentsDirectory();
    case 'ios':
    case 'macos':
      return getLibraryDirectory();
    case 'windows':
    case 'linux':
      return getApplicationSupportDirectory();
    default:
      return getTemporaryDirectory();
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getCorrectDirectory()).path),
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RandomWordCubit()..generateRandomWord(),
        ),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: "My Awesome Namer Flutte App",
            debugShowCheckedModeBanner: false,
            themeMode: themeState.themeMode,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.light,
              ),
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.dark,
              ),
            ),
            home: SafeArea(child: LayoutDispatcher()),
          );
        },
      ),
    );
  }
}
