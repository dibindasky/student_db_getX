import 'package:get/state_manager.dart';
import 'package:student_getx/controller/db/db_functions.dart';
import 'package:student_getx/model/student_model.dart';

class StudentListController extends GetxController{
  Sql sql=Sql();

  RxList<Student> studentList=<Student>[].obs;

  Future<void> getStudents(String name)async{
    List<Student> tempList=await sql.getData();
        studentList.clear();
         studentList.addAll(
      tempList.where((model) => model.name.toLowerCase().contains(name.toLowerCase())).toList(),
    );
  }

}