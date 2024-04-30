import 'package:book_buddy/constants/language_constant.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String author;
  final int available;
  final String image;
  const BookCard(
      {super.key,
      required this.title,
      required this.author,
      required this.available,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        children: [
          Image.asset(
            image,
            height: 300,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_circle_up_sharp),
                  iconSize: 50,
                  color: Colors.green,
                ),
              ),
              Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    translation(context).by + author,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ),
                  Text('${translation(context).stock}$available',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 31, 137, 38),
                          fontSize: 16)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_circle_down_sharp),
                  iconSize: 50,
                  color: const Color.fromARGB(255, 216, 24, 24),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
