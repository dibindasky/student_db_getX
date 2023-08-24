import 'package:flutter/material.dart';
import 'package:student_getx/controller/db/db_functions.dart';
import 'package:student_getx/core/constants.dart';
import 'package:student_getx/view/screens/screen_home.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Sql sql=Sql();
  await sql.initialiseDatabase();

  runApp(const StudentApp());
}

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          canvasColor: kwhite,
          primaryColor: Colors.blueAccent,
          appBarTheme: const AppBarTheme(
              backgroundColor: kblack,
              centerTitle: true,
              foregroundColor: kwhite,iconTheme: IconThemeData(color: kwhite))),
      home: ScreenHome(),
    );
  }
}
