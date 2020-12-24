import 'package:flutter/material.dart';
import 'package:mynote/ui/views/note/user_view.dart';
import 'package:mynote/ui/views/note/user_view_add.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login",
      home: UserView(),
    );
  }
}
