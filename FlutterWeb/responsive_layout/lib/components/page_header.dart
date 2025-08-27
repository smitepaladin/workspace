import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'images/3.png',
          width: 800,
          color: Color.fromRGBO(255, 255, 255, 0.5),
          colorBlendMode: BlendMode.modulate,
        ),
        Text(
          'Our Courses',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: ResponsiveValue(
              context,
              defaultValue: 60.0,
              conditionalValues: [
                Condition.smallerThan(
                  value: 40.0, name: MOBILE
                ),
                Condition.largerThan(name: TABLET, value: 80.0)
              ],
            ).value,
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
        )
      ],
    );
  }
}