import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Text with Column Row2',
          style: TextStyle(
          fontWeight: FontWeight.bold
          ),
      ),
      centerTitle: true,
      backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Icon(Icons.email_rounded),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text('James'),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Icon(Icons.account_balance),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text('Cathy'),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Icon(Icons.account_circle),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text('Kenny'),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
            Center(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(110, 8, 8, 8),
                      child: Icon(Icons.email_rounded),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(110, 8, 8, 8),
                      child: Icon(Icons.account_balance),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(110, 8, 8, 8),
                      child: Icon(Icons.account_circle),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(34, 10, 10, 10),
                  child: Text('James'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(34, 10, 10, 10),
                  child: Text('Cathy'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(34, 10, 10, 10),
                  child: Text('Kenny'),
                ),
              ],
            ),
              ],
            )
          ],
        ),
        
      ),
    );
  }
}
