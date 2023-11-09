import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:interview_note_app/blocs/note/note_bloc.dart';
import 'package:interview_note_app/core/hive/hive_init.dart';
import 'package:interview_note_app/core/theme/theme_cubit.dart';
import 'package:interview_note_app/core/constants/constants.dart';
import 'package:interview_note_app/pages/login_page.dart';
import 'package:interview_note_app/pages/notes_page.dart';

Box? box;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  box = await openBox('noteApp');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  static String title = 'Notes SQLite';

  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => NoteBloc(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, state) {
          return MaterialApp(
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: child,
                ),
              );
            },
            themeMode: state ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData.light().copyWith(
              primaryColor: kGlacier,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              scaffoldBackgroundColor: kGlacier,
              cardColor: kFrost,
              primaryIconTheme: const IconThemeData(color: kMatte),
              brightness: Brightness.light,
              appBarTheme: Theme.of(context).appBarTheme.copyWith(
                    color: kGlacier,
                    iconTheme: const IconThemeData(color: Colors.black),
                    systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
                        statusBarColor: kGlacier,
                        statusBarIconBrightness: Brightness.dark,
                        systemNavigationBarColor: kGlacier),
                  ),
              textTheme: const TextTheme(
                displayLarge: TextStyle(
                  fontSize: 93,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -1.5,
                  color: kMatte,
                ),
                displayMedium: TextStyle(
                  fontSize: 58,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -0.5,
                  color: kMatte,
                ),
                displaySmall: TextStyle(
                  fontSize: 46,
                  fontWeight: FontWeight.w400,
                  color: kMatte,
                ),
                headlineMedium: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.25,
                  color: kMatte,
                ),
                headlineSmall: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.25,
                  color: kMatte,
                ),
                titleLarge: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.15,
                  color: kMatte,
                ),
                titleMedium: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.15,
                  color: kMatte,
                ),
                titleSmall: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.1,
                  color: kMatte,
                ),
                bodyLarge: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5,
                  color: kMatte,
                ),
                bodyMedium: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.25,
                  color: kMatte,
                ),
                labelLarge: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.25,
                  color: kMatte,
                ),
                bodySmall: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.4,
                  color: kMatte,
                ),
                labelSmall: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.5,
                  color: kMatte,
                ),
              ),
            ),
            darkTheme: ThemeData.dark().copyWith(
              primaryColor: kMatte,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              scaffoldBackgroundColor: kMatte,
              cardColor: kShadow,
              appBarTheme: Theme.of(context).appBarTheme.copyWith(
                    color: kMatte,
                    systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
                        statusBarColor: kMatte,
                        statusBarIconBrightness: Brightness.light,
                        systemNavigationBarColor: kMatte),
                  ),
              snackBarTheme: const SnackBarThemeData(
                backgroundColor: kShadow,
                behavior: SnackBarBehavior.floating,
              ),
              textTheme: const TextTheme(
                displayLarge: TextStyle(
                    fontSize: 93,
                    fontWeight: FontWeight.w300,
                    letterSpacing: -1.5),
                displayMedium: TextStyle(
                    fontSize: 58,
                    fontWeight: FontWeight.w300,
                    letterSpacing: -0.5),
                displaySmall:
                    TextStyle(fontSize: 46, fontWeight: FontWeight.w400),
                headlineMedium: TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.25),
                headlineSmall:
                    TextStyle(fontSize: 23, fontWeight: FontWeight.w400),
                titleLarge: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.15),
                titleMedium: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.15),
                titleSmall: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.1),
                bodyLarge: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5),
                bodyMedium: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.25),
                labelLarge: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.25),
                bodySmall: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.4),
                labelSmall: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.5),
              ),
            ),
            debugShowCheckedModeBanner: false,
            title: title,
            home: box!.get('user') == null ? LoginView() : const NotesPage(),
          );
        },
      ),
    );
  }
}
