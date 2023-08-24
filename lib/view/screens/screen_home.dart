import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_getx/core/constants.dart';
import 'package:student_getx/view/screens/screen_add_edit.dart';

import '../../controller/getx/student_list_controller.dart';
import '../../model/student_model.dart';
import '../widgets/home/list_tile.dart';
import '../widgets/home/search_textfield.dart';

ValueNotifier<bool> search = ValueNotifier(false);
String srarchValue = '';

class ScreenHome extends GetView {
  ScreenHome({super.key});

  final TextEditingController searchController = TextEditingController();
  final listController = Get.put<StudentListController>(StudentListController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) async{
      await listController.getStudents('');
    });
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
                  SearchBarText(size: size, searchController: searchController),
            ),
          ),
          // Other Sliver Widgets
          SliverList(
            delegate: SliverChildListDelegate([
              GetX<StudentListController>(
                builder: (listController) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: listController.studentList.length,
                    itemBuilder: (context, index) {
                      if (listController.studentList.isEmpty) {
                        return const Center(
                          child: Text('list is empty'),
                        );
                      }
                      final Student model = listController.studentList[index];
                      return ListStudentTile(
                        size: size,
                        model: model,
                      );
                    },
                  );
                },
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
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScreenDetails(action: ActionType.add),
              ));
        },
        label: const Text('Add new'),
      ),
    );
  }
}
