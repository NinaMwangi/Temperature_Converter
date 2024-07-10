import 'package:flutter/material.dart';
import 'package:temperature_converter/main.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Setting the main colors
  Color mainColor = Colors.white;
  Color secondColor = Colors.orange;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200.0,
                child: Text("Currency Converter", style:TextStyle(
                  color: Color.fromARGB(255, 255, 111, 0),
                  fontSize: 36,
                  fontWeight: FontWeight.bold
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}