import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_page.dart';
import 'goals_page.dart';

class stepGoal {
  final String title;
  final int targetSteps;
  int currentSteps;

  stepGoal({required this.title, required this.targetSteps, required this.currentSteps});
}

void saveGoals(List<stepGoal> goals) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  List<Map<String, dynamic>> goalList = goals
      .map((goal) => {'title': goal.title, 'targetSteps': goal.targetSteps, 'currentSteps': goal.currentSteps})
      .toList();

  await prefs.setStringList('goalList', goalList.map((goal) => jsonEncode(goal)).toList().cast<String>());
}

Future<List<stepGoal>> getGoals() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String>? goalList = prefs.getStringList('goalList');

  if (goalList != null) {
    return goalList.map((goal) {
      Map<String, dynamic> json = jsonDecode(goal);
      return stepGoal(title: json['title'], targetSteps: json['targetSteps'], currentSteps: json['currentSteps']);
    }).toList();
  }

  return [];
}

void saveSteps(steps) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('stepcount', steps);
}

Future<int> getSteps() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('stepcount') ?? 0;
}

class GoalWidget extends StatelessWidget {
  final stepGoal goal;

  GoalWidget({required this.goal});

  @override
  Widget build(BuildContext context) {
    double progress = goal.currentSteps / goal.targetSteps;
    String title = goal.title;
    int current = goal.currentSteps;
    int target = goal.targetSteps;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75, // 75% of screen width
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
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
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                decoration: const BoxDecoration(
                  color: Colors.white, // White background color
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ), // Rounded edges only at the bottom
                ),
                padding: const EdgeInsets.all(10.0), // Optional padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Center the text within the row
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 3,
                          color: Colors.green,
                        ),
                        Text(
                          '${(progress * 100).toStringAsFixed(1)}%',
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '$current / $target',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )

      ),
    );
  }
}


class homepage extends StatefulWidget {
  const homepage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int stepCount = 0;
  bool isPeak = false;
  double threshold = 1.0;
  double previousY = 0.0;
  List<stepGoal> goals = [
    stepGoal(title: 'Goal 1', targetSteps: 10000, currentSteps: 7500),
    stepGoal(title: 'Goal 2', targetSteps: 5000, currentSteps: 3500),
    stepGoal(title: 'Goal 3', targetSteps: 8000, currentSteps: 4000),
    stepGoal(title: 'Goal 4', targetSteps: 8000, currentSteps: 4000),
    stepGoal(title: 'Goal 5', targetSteps: 8000, currentSteps: 4000),
  ];

  @override
  void initState() {
    super.initState();
    startStepCounting();
  }


  void startStepCounting() async {
    List<stepGoal> awaitedGoals = await getGoals();
    int awaitedSteps = await getSteps();

    setState(() {
      stepCount = awaitedSteps;
      goals = awaitedGoals;
    });
    accelerometerEvents.listen((AccelerometerEvent event) {
      double currentY = event.y;
      double deltaY = currentY - previousY;

      if (deltaY > 0 && !isPeak) {
        isPeak = true;
      } else if (deltaY < 0 && isPeak) {
        isPeak = false;
        if (deltaY.abs() > threshold) {
          setState(() {
            stepCount++;
            print(stepCount);
            goals.forEach((goal) {
              goal.currentSteps += 1;
            });
          });
          saveGoals(goals);
          saveSteps(stepCount);
        }
      }

      previousY = currentY;
    });
  }

  @override
  void dispose() {
    super.dispose();
    accelerometerEvents.drain();
  }

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
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 0.5, // Adjust the scale factor as needed
                          child: Image.asset('assets/images/stapplogo.png'),
                        ),
                        const SizedBox(
                            width:
                            8), // Adding some spacing between the image and text
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return const ProfilePage(title: 'Profilepage');
                          }));
                    },
                    child: const Text('profile >'),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width *
                  0.75, // 75% of screen width
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        '$stepCount',
                        style: TextStyle(
                          fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold, decoration: TextDecoration.none,),

                      ),
                    ),
                  ),
                  const SizedBox(width: 10), // Adding spacing between the elements
                  const Text(
                    'Walked',
                    style: TextStyle(fontSize: 20, color: Colors.green, decoration: TextDecoration.none,),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const Goalspage(title: 'Goalspage');
                  }));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[700], // Set the background color to dark green
                  minimumSize: const Size(0, 50), // Set the height to 50 and width to fit the text
                ),
                child: const Text(
                  'Goals >',
                  style: TextStyle(
                    fontSize: 20, // Set the text size to 20
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: goals.length,
                  itemBuilder: (BuildContext context, int index) {
                    stepGoal goal = goals[index];
                    return GoalWidget(goal: goal);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

