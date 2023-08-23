import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../screens/screen_home.dart';

class SearchBarText extends StatelessWidget {
  const SearchBarText({
    super.key,
    required this.size,
    required this.searchController,
  });

  final Size size;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.05,
      decoration: const BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 1, spreadRadius: 1)],
          color: kwhite,
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: TextField(
        onChanged: (value) {
          srarchValue = value;
        },
        cursorColor: kblack,
        controller: searchController,
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search_sharp),
            prefixIconColor: kblack,
            border: InputBorder.none),
        style: const TextStyle(
            color: kblack, fontWeight: FontWeight.w300, fontSize: 18),
      ),
    );
  }
}
