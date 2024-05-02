import 'package:book_buddy/constants/language_constant.dart';
import 'package:book_buddy/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySignIn extends StatelessWidget {
   MySignIn({super.key});

  final TextEditingController userController = TextEditingController();
  
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/Logo.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 110, top: 220),
              child: Text(translation(context).bookBuddy,
                  style: Theme.of(context).copyWith().textTheme.titleLarge),
            ),
            Container(
              padding: const EdgeInsets.only(left: 110, top: 255),
              child: Text(
                translation(context).anTandemloopCompany,
                style: Theme.of(context).copyWith().textTheme.titleSmall,
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.43,
                    right: 35,
                    left: 35),
                child: Column(
                  children: [
                    TextField(
                      controller: userController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).primaryColor,
                          hintText: translation(context).userName,
                          hintStyle: Theme.of(context)
                              .copyWith()
                              .textTheme
                              .titleMedium,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25))),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          fillColor: Theme.of(context).primaryColor,
                          filled: true,
                          hintText: translation(context).password,
                          hintStyle: Theme.of(context)
                              .copyWith()
                              .textTheme
                              .titleMedium,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25))),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    CircleAvatar(
                        radius: 34,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: IconButton(
                          onPressed: () async {
                            final SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            sharedPreferences.setString(
                                'user', userController.text);
                            sharedPreferences.setString(
                                'password', passwordController.text);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyHome()));
                          },
                          icon: const Icon(Icons.arrow_right_alt),
                          color: const Color.fromARGB(255, 10, 10, 10),
                          iconSize: 50,
                        )),
                    Text(
                      translation(context).signIn,
                      style:
                          Theme.of(context).copyWith().textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(translation(context).alreadyHaveAnAccount,
                            style: Theme.of(context)
                                .copyWith()
                                .textTheme
                                .headlineSmall),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              translation(context).login,
                              style: Theme.of(context)
                                  .copyWith()
                                  .textTheme
                                  .headlineSmall,
                            ))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
