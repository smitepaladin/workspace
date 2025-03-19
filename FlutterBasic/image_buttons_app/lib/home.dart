import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buttons"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'images/apple.jpg',
                    height: 120,
                    width: 120,
                    fit: BoxFit.fill
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'images/banana.jpg',
                    height: 120,
                    width: 120,
                    fit: BoxFit.fill
                  ),
                ),
              ],
            ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'images/peach.jpg',
                    height: 120,
                    width: 120,
                    fit: BoxFit.fill
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'images/pineapple.jpg',
                    height: 120,
                    width: 120,
                    fit: BoxFit.fill
                  ),
                ),
              ],
            ),
              SizedBox(height: 200),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                    onPressed: () => print("Elevated Buttons"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.yellow,
                      backgroundColor: Colors.blue,
                      minimumSize: Size(130,40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      )
                    ),
                    child: Text('apple'),
                    ),
                  ),


                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                              onPressed: () => print("Elevated Buttons"),
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.yellow,
                                                backgroundColor: Colors.blue,
                                                minimumSize: Size(130,40),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20)
                                                )
                                              ),
                                              child: Text('banana'),
                                              ),
                              ),
                ],
              ),


                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                    onPressed: () => print("Elevated Buttons"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.yellow,
                      backgroundColor: Colors.blue,
                      minimumSize: Size(130,40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      )
                    ),
                    child: Text('peach'),
                    ),
                  ),


                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                              onPressed: () => print("Elevated Buttons"),
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.yellow,
                                                backgroundColor: Colors.blue,
                                                minimumSize: Size(130,40),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20)
                                                )
                                              ),
                                              child: Text('pineapple'),
                                              ),
                              ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}