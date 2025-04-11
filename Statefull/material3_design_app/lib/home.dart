import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material3 Design'),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    color: Theme.of(context).colorScheme.primary,// main.dart에 있는메인컬러를 쓰겠다.
                    alignment: Alignment(0, 0),
                    child: Text(
                      'Primary Color',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary // on은 보색개념
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    color: Theme.of(context).colorScheme.secondary,// main.dart에 있는메인컬러를 쓰겠다.
                    alignment: Alignment(0, 0),
                    child: Text(
                      'Secondary Color',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary // on은 보색개념
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    color: Theme.of(context).colorScheme.tertiary,
                    alignment: Alignment(0, 0),
                    child: Text(
                      'Tertiary Color',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onTertiary 
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    color: Theme.of(context).colorScheme.error,
                    alignment: Alignment(0, 0),
                    child: Text(
                      'Error Color',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onError 
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    color: Theme.of(context).colorScheme.primaryContainer,// main.dart에 있는메인컬러를 쓰겠다.
                    alignment: Alignment(0, 0),
                    child: Text(
                      'Primary Color',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer // Container는 연한색
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    color: Theme.of(context).colorScheme.secondaryContainer,// main.dart에 있는메인컬러를 쓰겠다.
                    alignment: Alignment(0, 0),
                    child: Text(
                      'Secondary Color',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondaryContainer // on은 보색개념
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    alignment: Alignment(0, 0),
                    child: Text(
                      'Tertiary Color',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onTertiaryContainer 
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    color: Theme.of(context).colorScheme.errorContainer,
                    alignment: Alignment(0, 0),
                    child: Text(
                      'Error Color',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onErrorContainer 
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }// build
}// Class