import 'dart:math';

import 'package:e/app/app_colors.dart';
import 'package:flutter/material.dart';

final TextStyle appStyle = TextStyle(
  color: AppColors.primaryColor,
  fontWeight: FontWeight.w500,
  fontSize: 16,
);

class AppSpace extends StatelessWidget {
  const AppSpace({super.key, this.axis = Axis.vertical, this.percentage = .1});
  final Axis axis;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: (axis == Axis.vertical) ? size.height * percentage : null,
      width: (axis == Axis.horizontal) ? size.width * percentage : null,
    );
  }
}

void unFocus(BuildContext context) => FocusScope.of(context).unfocus();

extension Click on Widget {
  Widget callback({VoidCallback? onTap}) => InkWell(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: this,
      );
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\])|(([a-zA-Z\-\d]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

String generateRandomUsername() {
  final Random random = Random();

  // List of adjectives and nouns for creating usernames
  List<String> adjectives = [
    'Happy',
    'Silly',
    'Brave',
    'Clever',
    'Gentle',
    'Fast'
  ];
  List<String> nouns = [
    'Panda',
    'Tiger',
    'Dolphin',
    'Dragon',
    'Rabbit',
    'Eagle'
  ];

  String adjective = adjectives[random.nextInt(adjectives.length)];
  String noun = nouns[random.nextInt(nouns.length)];

  // Generating a random number between 100 and 999
  int randomNumber = 100 + random.nextInt(900);

  return '$adjective$noun$randomNumber';
}

void showToast(BuildContext context, [String msg = '']) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
final foods = [
  "pizza",
  "sushi",
  "burger",
  "pasta",
  "salad",
  "tacos",
  "ice cream",
  "steak",
  "curry",
  "ramen",
  "fried chicken",
  "pancakes",
  "burrito",
  "lasagna",
  "sushi",
  "fries",
  "shawarma",
  "pad thai",
  "sushi",
  "dumplings"
];

String getDate(DateTime d) =>
    "${d.day}/${d.month}/${d.year} - ${d.hour > 12 ? (d.hour - 11) : d.hour}:${d.minute} ${d.hour > 12 ? "pm" : "am"}";
