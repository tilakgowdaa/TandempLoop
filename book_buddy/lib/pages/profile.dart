import 'package:book_buddy/constants/language.dart';
import 'package:book_buddy/constants/language_constant.dart';
import 'package:book_buddy/main.dart';
import 'package:book_buddy/pages/home.dart';
import 'package:book_buddy/pages/signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/theme_provider.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String finalUser = '';

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      finalUser = sp.getString('user')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(PageRouteBuilder(
                        opaque: true,
                        transitionDuration: const Duration(microseconds: 100),
                        pageBuilder: (BuildContext context, _, __) {
                          return const MyHome();
                        },
                        transitionsBuilder:
                            (_, Animation<double> animation, __, Widget child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(-1, 0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          );
                        }));
                  },
                  icon: const Icon(Icons.arrow_back))
            ],
          ),
          Container(
            height: 170,
            width: 170,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image:
                    DecorationImage(image: AssetImage('assets/profile.png'))),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              finalUser,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 15),
                width: 380,
                height: 80,
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Text(
                      translation(context).language,
                      style:
                          Theme.of(context).textTheme.copyWith().headlineMedium,
                    ),
                    Text(
                      translation(context).languageKey,
                      style: Theme.of(context).textTheme.copyWith().labelMedium,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 110),
                child: DropdownButton<Language>(
                  underline: const SizedBox(),
                  icon: const Icon(
                    Icons.arrow_right_alt_rounded,
                    color: Color.fromARGB(255, 218, 205, 218),
                    size: 50,
                  ),
                  onChanged: (Language? language) async {
                    if (language != null) {
                      Locale _locale = await setLocale(language.languageCode);
                      MyApp.setLocale(context, _locale);
                    }
                  },
                  items: Language.languageList()
                      .map<DropdownMenuItem<Language>>(
                        (e) => DropdownMenuItem<Language>(
                          value: e,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                e.flag,
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(e.name)
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(
                    top: 5,
                    left: 10,
                  ),
                  width: 380,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.dark_mode_sharp,
                        size: 33,
                        color: Color.fromARGB(255, 251, 249, 249),
                      ),
                      Text(translation(context).dark,
                          style: Theme.of(context)
                              .textTheme
                              .copyWith()
                              .headlineMedium)
                    ],
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 150),
            child: Consumer<ThemeProvider>(
                builder: (context, ThemeProvider notifier, child) {
              return ListTile(
                trailing: Switch(
                    value: notifier.dark,
                    onChanged: (value) => notifier.changeTheme()),
              );
            }),
          ),
          CircleAvatar(
              radius: 34,
              backgroundColor: Theme.of(context).primaryColor,
              child: IconButton(
                onPressed: () async {
                  final SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.remove('user');
                  sharedPreferences.remove('password');
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MySignIn()));
                },
                icon: const Icon(Icons.logout_rounded),
                color: const Color.fromARGB(255, 10, 10, 10),
                iconSize: 50,
              )),
          Text(
            translation(context).signOut,
            style: Theme.of(context).copyWith().textTheme.headlineMedium,
          )
        ],
      )),
    );
  }
}
