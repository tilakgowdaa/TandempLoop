import 'package:book_buddy/constants/language_constant.dart';
import 'package:book_buddy/pages/home.dart';
import 'package:book_buddy/pages/signin.dart';
import 'package:book_buddy/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? currentLocale;

  setLocale(Locale locale) {
    setState(() {
      currentLocale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ThemeProvider()..init(),
      child: Consumer<ThemeProvider>(
          builder: (context, ThemeProvider notifier, child) {
        return MaterialApp(
            title: 'Book Buddy',
            debugShowCheckedModeBanner: false,
            theme: notifier.dark ? notifier.darkTheme : notifier.lightTheme,
            locale: currentLocale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            initialRoute: 'signin',
            routes: {
              'signin': (context) => const MySignIn(),
              'home': (context) => const MyHome(),
            });
      }),
    );
  }
}
