import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'goals_page.dart';

class homepage extends StatelessWidget {
  const homepage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen,
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
                            color: Colors.white,
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
                    child: const Center(
                      child: Text(
                        '4500',
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
                        'How fast con I hit 2K',
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
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Colors.white, // White background color
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ), // Rounded edges only at the bottom
                      ),
                      padding: const EdgeInsets.all(10.0), // Optional padding
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Center the text within the row
                        children: [
                          Text(
                            'img of progression',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Text(
                            '1400/2000',
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
              ),
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
                        'Weekly',
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
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Colors.white, // White background color
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ), // Rounded edges only at the bottom
                      ),
                      padding: const EdgeInsets.all(10.0), // Optional padding
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Center the text within the row
                        children: [
                          Text(
                            'img of progression',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Text(
                            '4500 / 40000',
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
