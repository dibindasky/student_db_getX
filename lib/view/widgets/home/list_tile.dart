import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_getx/core/constants.dart';
import 'package:student_getx/view/screens/screen_add_edit.dart';
import 'package:student_getx/view/screens/screen_home.dart';
import 'package:student_getx/view/widgets/circle_avathar.dart';

import '../../../model/student_model.dart';
import 'profile_tile.dart';

class ListStudentTile extends StatelessWidget {
  const ListStudentTile({super.key, required this.size, required this.model});

  final Size size;
  final Student model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.10,
      child: Center(
        child: ListTile(
          tileColor: kblack.withOpacity(0.1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onTap: () {
            Get.to(showPopUp(context: context, model: model));
            // showProfile(context: context, model: model);
          },
          leading: CircleImage(
            radius: 50,
            image: model.image,
          ),
          title: Text(model.name),
          subtitle: Text(model.phone),
          trailing: Wrap(children: [
            IconButton(
                onPressed: () {
                  Get.to(ScreenDetails(
                    action: ActionType.edit,
                    model: model,
                  ));
                  setData(model);
                },
                icon: const Icon(Icons.edit_document)),
            IconButton(
                onPressed: () async {
                  Get.to(
                      showPopUp(context: context, model: model, delete: true));
                  // await sql.deleteData(model.id!);
                },
                icon: Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.red,
                ))
          ]),
        ),
      ),
    );
  }

  showPopUp(
      {required BuildContext context,
      required Student model,
      bool delete = false}) {
    showDialog(
      context: context,
      builder: (context) => delete
          ? AlertDialog(
              title: const Text('Are you Sure want to delete ?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () async {
                      await listController.deleteStudent(model.id!);
                      Get.back();
                      Get.snackbar('Deleted Sucessfully', '',
                          messageText: Text(
                            '${model.name} is been removed',
                            style: const TextStyle(color: kblack),
                          ),
                          colorText: kwhite,
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(milliseconds: 1000),
                          backgroundColor: Colors.redAccent.withOpacity(0.85));
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.redAccent),
                    ))
              ],
            )
          : ProfileTile(size: size, model: model),
    );
  }
}
