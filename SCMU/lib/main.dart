import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scmu/components/notification.dart';
import 'package:scmu/pages/login_page.dart';
import 'homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:scmu/pages/auth.dart';
import 'package:scmu/setings.dart';
import 'package:scmu/list.dart';
import 'package:scmu/history.dart';
import 'package:scmu/homepage.dart';
import 'package:scmu/provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.initializeNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider( // Using MultiProvider for both providers
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => UiProvider()..ini(),
        ),
        // Add more providers if needed
      ],
      child: Consumer<UiProvider>(
        builder: (context, UiProvider notifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'App Title',
            // Using theme mode from the dark theme snippet
            themeMode: notifier.isDark ? ThemeMode.dark : ThemeMode.light,
            darkTheme: notifier.isDark ? notifier.darkTheme : notifier.lightTheme,
            theme: ThemeData(
              // Your custom theme settings
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            // Setting the default home to Auth from the second snippet
            home: Auth(),
            routes: {
              // Defining routes from the second snippet
              '/Home': (context) => HomePageApp(),
              '/Offices': (context) => listPage(),
              '/Historico': (context) => historyPage(),
              '/Settings': (context) => const settingsPage(),
            },
          );
        },
      ),
    );
  }
}


