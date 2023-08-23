import 'package:flutter/material.dart';
import 'package:student_getx/controller/db_functions.dart';
import 'package:student_getx/core/constants.dart';
import 'package:student_getx/view/screens/screen_add_edit.dart';

import '../../model/student_model.dart';
import '../widgets/home/list_tile.dart';
import '../widgets/home/search_textfield.dart';

ValueNotifier<bool> search = ValueNotifier(false);
String srarchValue = '';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});

  final TextEditingController searchController = TextEditingController();

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
              title: SearchBarText(size: size, searchController: searchController),
            ),
          ),
          // Other Sliver Widgets
          SliverList(
            delegate: SliverChildListDelegate([
              ValueListenableBuilder(
                valueListenable: studentListNotifier,
                builder: (context, students, _) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final Student model = students[index];
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

