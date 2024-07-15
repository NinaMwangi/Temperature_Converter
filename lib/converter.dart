import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'conversion.dart';

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
  final List<Conversion> _conversionHistory = [];

  void _convert() {
    setState(() {
      if (isFahr) {
        outTemp = (inTemp - 32) * 5 / 9;
      } else {
        outTemp = (inTemp * 9 / 5) + 32;
      }

      // Restrict output to one decimal place
      String roundedOutTemp = outTemp.toStringAsFixed(1);

      Conversion newConversion = Conversion(
        id: const Uuid().v4(),
        input: inTemp,
        output: roundedOutTemp,
        isFahrToCelsius: isFahr,
        );

      _conversionHistory.insert(0, newConversion);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Result'),
          content: isFahr
              ? Text('$inTemp Fahrenheit = $roundedOutTemp Celsius')
              : Text('$inTemp Celsius = $roundedOutTemp Fahrenheit'),
        ),
      );
    });
  }

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
                child: Text("Temperature Converter",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 111, 0),
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter Temperature',
                        labelText: isFahr 
                        ? '$inTemp entered in Fahrenheit'
                        : '$inTemp entered in Celsius'
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (newValue) {
                        setState(() {
                          try {
                            inTemp = double.parse(newValue);
                          } catch (e) {}
                        });
                      },
                    ),
                    RadioListTile(
                      value: true,
                      groupValue: isFahr,
                      title: const Text(
                        'Fahrenheit', 
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 111, 0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onChanged: (newValue){
                        setState(() {
                          isFahr = newValue!;
                        });
                      },
                      activeColor: Colors.black87,
                    ),
                    RadioListTile(
                      value: false,
                      groupValue: isFahr,
                      title: const Text(
                        'Celsius',
                        style: TextStyle(
                          color:Color.fromARGB(255, 255, 111, 0),
                          fontWeight: FontWeight.bold
                        ),),
                      onChanged: (newValue){
                        setState(() {
                          isFahr = newValue!;
                        });
                      },
                      activeColor: Colors.black87,
                    ),
                    ElevatedButton(
                      onPressed: _convert,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 234, 137, 63),
                      ),
                      child: const Text(
                        'Convert',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'History',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 234, 137, 63),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListView.builder(
                          itemCount: _conversionHistory.length,
                          itemBuilder: (context, index) {
                            final conversion = _conversionHistory[index];
                            return ListTile(
                              title: Text(
                                conversion.isFahrToCelsius
                                  ? '${conversion.input} Fahrenheit = ${conversion.output} Celsius'
                                  : '${conversion.input} Celsius = ${conversion.output} Fahrenheit',
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          },
                          reverse: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}