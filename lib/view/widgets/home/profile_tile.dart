import 'package:flutter/material.dart';
import 'package:student_getx/model/student_model.dart';

import '../../../core/constants.dart';
import '../circle_avathar.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.size, required this.model,
  });

  final Size size;
  final Student model;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(backgroundColor: kwhite,
          title: CircleImage(radius: 70,image: model.image),
          content: SizedBox(
            height: size.height * 0.15,
            child: Column(
              children: [
                const Spacer(),
                Row(
                  children: [
                    const Text('Name   :'),kwidth20,Text(model.name,style: textStyle,)
                  ],
                ),
                kheight10,
                Row(
                  children: [
                    const Text('Age       :'),kwidth20, Text(model.age,style: textStyle,)
                  ],
                ),
                kheight10,
                Row(
                  children: [
                    const Text('Phone   :'),kwidth20,Text(model.phone,style: textStyle,)
                  ],
                ),
                const Spacer()
              ],
            ),
          ),
        );
  }
}

