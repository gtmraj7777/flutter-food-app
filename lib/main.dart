import 'package:flutter/material.dart';
import 'package:flutter_food_app/widget/HomeScreen.dart';

void main() {
  runApp(MyWidget());
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (contex) => HomeScreen(),
        //  "/registration":(contex) => Registration(),
        // "/login":(contex) => LoginScreen(),
        //  "/category":(contex) => CategoryScreen(),
        // "/error":(contex) => ErrorScreen(),
      },
    );
  }
}
