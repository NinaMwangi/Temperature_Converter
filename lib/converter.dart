import 'package:flutter/material.dart';
import 'package:temperature_converter/main.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Setting the main colors
  Color mainColor = Colors.white;
  Color secondColor = Colors.orange;
  // Declaring variables
  double inTemp = 0.0, outTemp = 0.0;
  bool isFahr = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 200.0,
                child: Text("Currency Converter", style:TextStyle(
                  color: Color.fromARGB(255, 255, 111, 0),
                  fontSize: 36,
                  fontWeight: FontWeight.bold
                   ),
                ),
              ),
              //SizedBox(height: 20.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextField(
                      decoration: InputDecoration(hintText: 'Enter Temperature'),
                      keyboardType: TextInputType.number,
                    ),
                    RadioListTile(
                      value: true,
                      groupValue: isFahr,
                      title: const Text('Fahrenheit'),
                      onChanged: (newValue){
                        setState(() {
                          isFahr = newValue!;
                        });
                      },
                    ),
                    RadioListTile(
                      value: false,
                      groupValue: isFahr,
                      title: const Text('Celsius'),
                      onChanged: (newValue){
                        setState(() {
                          isFahr= newValue!;
                        });
                      }
                    ),
                    ElevatedButton(
                      onPressed: (){},
                      child: const Text('Convert'),
                    )
                  ],
                )
              ),
            ]
          ),
        ),
      ),
    );
  }
}