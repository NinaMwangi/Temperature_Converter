import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'conversion.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
  final TextEditingController _controller = TextEditingController();

  void _convert() {
    if (_controller.text.isEmpty) return; // Prevent conversion with empty input

    setState(() {
      try {
        inTemp = double.parse(_controller.text);
      } catch (e) {
        // Handle parse error if needed
        return;
      }

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

      // Clear input field after conversion
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 200.0,
                  child: Text(
                    "Temperature Converter",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 111, 0),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Enter Temperature',
                        labelText: isFahr
                            ? '$inTemp entered in Fahrenheit'
                            : '$inTemp entered in Celsius',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (newValue) {
                        setState(() {
                          // Update inTemp as user types
                          if (newValue.isNotEmpty) {
                            try {
                              inTemp = double.parse(newValue);
                            } catch (e) {
                              // Handle parse error if needed
                            }
                          } else {
                            inTemp = 0.0; // Reset inTemp if input is empty
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            value: true,
                            groupValue: isFahr,
                            title: const Text(
                              'Fahrenheit',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 111, 0),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                isFahr = newValue!;
                              });
                            },
                            activeColor: Colors.black87,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            value: false,
                            groupValue: isFahr,
                            title: const Text(
                              'Celsius',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 111, 0),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                isFahr = newValue!;
                              });
                            },
                            activeColor: Colors.black87,
                          ),
                        ),
                      ],
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
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 234, 137, 63),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.4, // Adjust height accordingly
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
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
                        },  // Show latest conversion at the top
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}