import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_getx/core/constants.dart';
import 'package:student_getx/view/screens/screen_add_edit.dart';

import '../../controller/getx/student_list_controller.dart';
import '../../model/student_model.dart';
import '../widgets/home/list_tile.dart';
import '../widgets/home/search_textfield.dart';

final listController = Get.put(StudentListController());


class ScreenHome extends GetView {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kwhite,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: true,
            title: const Text('Students Data'),
            bottom: AppBar(
              title:
                  SearchBarText(size: size),
            ),
          ),
          // Other Sliver Widgets
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GetX<StudentListController>(
                  builder: (listController) {
                    return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final Student model =
                              listController.studentList[index];
                          return ListStudentTile(size: size, model: model);
                        },
                        separatorBuilder: (context, index) => kheight5,
                        itemCount: listController.studentList.length);
                  },
                ),
              )
            ]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kblack,
        foregroundColor: kwhite,
        onPressed: () {
          clear();
          Get.to(ScreenDetails(action: ActionType.add));
        },
        label: const Text('Add new'),
      ),
    );
  }
}
