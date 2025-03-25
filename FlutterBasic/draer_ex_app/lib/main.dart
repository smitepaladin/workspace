import 'package:flutter/material.dart';
import 'mail.dart';
import 'view/sendmail/sendmail.dart';
import 'view/receivedmail/receivedmail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => Mail(),
        '/send' : (context) => Sendmail(),
        '/receive' : (context) => Receivedmail(),
      },
    );
  }
}