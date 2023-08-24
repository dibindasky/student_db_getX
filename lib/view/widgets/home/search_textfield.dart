import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants.dart';
import '../../screens/screen_home.dart';

class SearchBarText extends GetView {
  SearchBarText({
    super.key,
    required this.size,
  });

  final Size size;
  @override
  Widget build(BuildContext context) {
    listController.getStudents('');
    return Container(
      height: size.height * 0.05,
      decoration: const BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 1, spreadRadius: 1)],
          color: kwhite,
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: TextField(
        onChanged: (value) async {
          print('send request');

          await listController.getStudents(value);
          print('back request');
        },
        cursorColor: kblack,
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
