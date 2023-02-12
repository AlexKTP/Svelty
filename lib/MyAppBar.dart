import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {

  @override
  final Size preferredSize;

  final String title = "SVELTY";
  final bool backButton;

  MyAppBar(
      this.backButton, {super.key}) : preferredSize = const Size.fromHeight(55.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(color: Colors.greenAccent),
      ),
      automaticallyImplyLeading: true,
    );
  }
}