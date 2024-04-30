import 'package:book_buddy/constants/language_constant.dart';
import 'package:book_buddy/pages/book_data.dart';
import 'package:book_buddy/pages/book_card.dart';
import 'package:book_buddy/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  String finalUser = '';
  String finalPassword = '';

  List<Map<String, Object>> resultBooks = [];

  getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      finalUser = sp.getString('user')!;
      finalPassword = sp.getString('password')!;
    });
  }

  @override
  void initState() {
    getUser();
    resultBooks = books;
    super.initState();
  }

  void searchBook(String query) {
    List<Map<String, Object>> result = [];
    if (query.isEmpty) {
      result = books;
    } else {
      result = books
          .where((element) =>
              element['title']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              element['author']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    }
    setState(() {
      resultBooks = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide:
          BorderSide(color: Color.fromARGB(255, 200, 197, 197), width: 2),
      borderRadius: BorderRadius.horizontal(left: Radius.circular(50)),
    );
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/BG2.jpg'), fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      translation(context).bookBuddy,
                      style: Theme.of(context).copyWith().textTheme.titleLarge,
                    ),
                    IconButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              opaque: true,
                              transitionDuration:
                                  const Duration(milliseconds: 60),
                              pageBuilder: (BuildContext context, _, __) {
                                return const MyProfile();
                              },
                              transitionsBuilder: (_,
                                  Animation<double> animation,
                                  __,
                                  Widget child) {
                                return SlideTransition(
                                  child: child,
                                  position: Tween<Offset>(
                                    begin: const Offset(1, 0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                );
                              }));
                        },
                        icon: const Icon(
                          Icons.account_circle_rounded,
                          size: 55,
                        )),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        translation(context).finalUser + finalUser,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    Expanded(
                        child: SizedBox(
                      height: 45,
                      child: TextField(
                        onChanged: (value) => searchBook(value),
                        decoration: InputDecoration(
                          hintText: translation(context).search,
                          hintStyle: Theme.of(context).textTheme.headlineSmall,
                          prefixIcon: const Icon(Icons.search),
                          prefixIconColor:
                              const Color.fromARGB(255, 119, 95, 95),
                          border: border,
                          enabledBorder: border,
                        ),
                      ),
                    ))
                  ],
                ),
                Expanded(
                    child: resultBooks.isNotEmpty
                        ? ListView.builder(
                            itemCount: resultBooks.length,
                            itemBuilder: (context, index) {
                              final book = resultBooks[index];
                              return BookCard(
                                  title: book['title'] as String,
                                  author: book['author'] as String,
                                  available: book['available'] as int,
                                  image: book['image'] as String);
                            })
                        : Text(
                            translation(context).noResultsFound,
                            style: const TextStyle(color: Colors.red),
                          ))
              ],
            ),
          )),
    );
  }
}
