import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:getx_intro_app/third_page.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: [ // pubspec.yaml에서 추가해야한다. // 캘린더 국가 맞추기 위해 사용
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Home(), // 일반적 Route사용과 달리 Home을 지울 필요가없다.
      getPages: [
        GetPage(
          name: '/third',
          page: () => ThirdPage(),
        ),
        GetPage(
          name: '/third2',
          page: () => ThirdPage(),
          transition: Transition.circularReveal,
          transitionDuration: Duration(seconds: 5)
        ),
      ],
    );
  }
}