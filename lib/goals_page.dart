import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_page.dart';

class Goalspage extends StatefulWidget {
  const Goalspage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _GoalspageState createState() => _GoalspageState();
}

class _GoalspageState extends State<Goalspage> {
  String inputTitle = '';
  int inputTargetSteps = 0;
  int inputCurrentSteps = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.lightGreen,
        image: DecorationImage(
          image: AssetImage('assets/images/Background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Transform.scale(
                        scale: 0.5, // Adjust the scale factor as needed
                        child: Image.asset('assets/images/stapplogo.png'),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ), // Adding some spacing between the image and text
                      const Text(
                        'Stapp',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const homepage(title: 'homepage');
                        },
                      ),
                    );
                  },
                  child: const Text('Home >'),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.75, // 75% of screen width
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.green[700], // Dark green background color
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ), // Rounded edges only at the top
                      ),
                      alignment: Alignment.center, // Center the text within the container
                      padding: const EdgeInsets.all(10.0), // Optional padding
                      child: const Text(
                        'Add Goal',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Material(
                            child: TextField(
                              decoration: const InputDecoration(
                                labelText: 'Title',
                                labelStyle: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  inputTitle = value;
                                });
                              },
                            ),
                          ),
                          Material(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                labelText: 'Target amount of steps',
                                labelStyle: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  inputTargetSteps = int.parse(value);
                                  assert(inputTargetSteps is int);
                                });
                              },
                            ),
                          ),
                          Material(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                labelText: 'Current amount of steps',
                                labelStyle: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  inputCurrentSteps = int.parse(value);
                                  assert(inputCurrentSteps is int);
                                });
                              },
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (inputTitle != null && inputTitle.isNotEmpty &&
                                  inputTargetSteps != null && inputTargetSteps.toString().isNotEmpty) {
                                stepGoal inputGoal = stepGoal(
                                  title: inputTitle,
                                  targetSteps: inputTargetSteps,
                                  currentSteps: inputCurrentSteps,
                                );
                                addGoal(inputGoal);

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Goal Added'),
                                      content: const Text('The goal has been added to your goals.'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Error'),
                                      content: const Text('Please fill in both the title and target steps.'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: const Text('Add'),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
