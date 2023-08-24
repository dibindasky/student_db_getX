// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_getx/controller/db/db_functions.dart';
import 'package:student_getx/controller/functions/validator_functions.dart';
import 'package:student_getx/core/constants.dart';
import 'package:student_getx/model/student_model.dart';

import '../../controller/getx/student_list_controller.dart';
import '../widgets/circle_avathar.dart';
import '../widgets/add_edit/text_field.dart';

enum ActionType {
  add,
  edit,
}

File? image;
final TextEditingController nameController = TextEditingController();
final TextEditingController ageController = TextEditingController();
final TextEditingController phoneController = TextEditingController();

class ScreenDetails extends StatelessWidget {
  ScreenDetails({super.key, required this.action, this.model});

  final ActionType action;
  final formKey = GlobalKey<FormState>();
  final Sql sql = Sql();
  final Student? model;
  final listController = Get.put(StudentListController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: action == ActionType.add
            ? const Text('Add Student')
            : const Text('Edit Student'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: const EdgeInsets.all(30),
          child: Form(
            key: formKey,
            child: SizedBox(
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  kheight50,
                  InkWell(
                      onTap: () async {
                        await pickImage();
                      },
                      child: CircleImage(
                        radius: 100,
                        image: image,
                      )),
                  kheight50,
                  TextFieldItem(
                      function: isAlphabet,
                      size: size,
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      header: 'name'),
                  kheight20,
                  TextFieldItem(
                      function: isValidAge,
                      size: size,
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      header: 'age'),
                  kheight20,
                  TextFieldItem(
                      function: isValidPhoneNumber,
                      size: size,
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      header: 'phone'),
                  kheight20,
                  ElevatedButton.icon(
                    onPressed: () async {
                      await addOrUpdate(context);
                    },
                    icon: action == ActionType.add
                        ? const Icon(Icons.check)
                        : const Icon(Icons.upload_file),
                    label: action == ActionType.add
                        ? const Text('add')
                        : const Text('update'),
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(kblack),
                      foregroundColor: MaterialStatePropertyAll(kwhite),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addOrUpdate(BuildContext context) async {
     if (formKey.currentState!.validate()) {
      await checkStudent();
      await listController.getStudents('');
      Navigator.pop(context);
      String message = action == ActionType.add
          ? 'Added Sucessfully'
          : 'Updated Sucessfully';
      Get.snackbar(
        message,
        '${nameController.text} $message',
        colorText: kblack,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(milliseconds: 1000),
        backgroundColor: Colors.greenAccent.withOpacity(0.85),
      );
    }
  }

  Future<void> pickImage() async {
    XFile? img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = File(img.path);
    }
  }

  Future<void> checkStudent() async {
    final model = Student(
        age: ageController.text.trim(),
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        image: image,
        id: this.model == null ? null : this.model!.id);
    ActionType.edit == action
        ? await sql.updateTable(model)
        : await sql.insertInToDb(model);
  }
}

clear() {
  nameController.text = '';
  ageController.text = '';
  phoneController.text = '';
  image = null;
}

setData(Student model) {
  nameController.text = model.name;
  ageController.text = model.age;
  phoneController.text = model.phone;
  image = model.image;
}
