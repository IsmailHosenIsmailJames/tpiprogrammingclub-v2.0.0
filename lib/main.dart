import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:tpiprogrammingclub/pages/post/post_editor.dart';
import 'auth/login/login.dart';
import 'pages/contents/contents.dart';
import 'pages/contributors/contributors.dart';
import 'pages/home/home_page.dart';
import 'widget/search.dart';
import 'package:url_strategy/url_strategy.dart';
import 'firebase_options.dart';
import 'theme/theme_provider.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'TPI Programming Club';

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);

          return MaterialApp(
            title: title,
            themeMode: themeProvider.themeMode,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            initialRoute: '/',
            routes: {
              "/": (context) => const PostEditor(),
              "/login": (context) => const LogIn(),
              "/home": (context) => const HomePage(),
              "/search": (context) => const Search(),
              "/contributors": (context) => const Contributors(),
            },
            onGenerateRoute: (settings) {
              String url = settings.name!;
              return MaterialPageRoute(
                builder: (context) => Contents(path: url),
                settings: settings,
                allowSnapshotting: true,
                maintainState: true,
              );
            },
          );
        },
      );
}
