import 'package:flutter/material.dart';
import 'package:student_getx/controller/functions/validator_functions.dart';

import '../../../core/constants.dart';

class TextFieldItem extends StatelessWidget {
  const TextFieldItem({
    super.key,
    required this.size,
    required this.controller,
    required this.header, required this.keyboardType, required this.function,
  });

  final Size size;
  final TextEditingController controller;
  final String header;
  final TextInputType keyboardType;
  final function;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$header : '),
        const Spacer(),
        Container(
          width: size.width * 0.70,
          decoration: BoxDecoration(
              color: kblack.withOpacity(0.1),
              borderRadius: const BorderRadius.all(Radius.circular(50))),
          child: TextFormField(
            validator: (value) {
              if(value!.isEmpty)return 'enter $header';
              if(functionValidator(function, value)){
                return null;
              }else{
                return 'enter valid $header';
              }
            },
            keyboardType: keyboardType,
              controller: controller,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w500),
              decoration: const InputDecoration(
                border: InputBorder.none,
              )),
        ),
      ],
    );
  }
}
