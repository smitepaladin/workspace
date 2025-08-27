import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_layout/components/appbar_title.dart';
import 'package:responsive_layout/components/course_title.dart';
import 'package:responsive_layout/components/menu_text_button.dart';
import 'package:responsive_layout/components/page_header.dart';
import 'package:responsive_layout/components/subscribe_block.dart';
import 'package:responsive_layout/model/course.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    List<Course> courses = Course.courses;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        centerTitle: true,
        title: AppbarTitle(),
        leading: ResponsiveVisibility(
          hiddenConditions: [
            Condition.largerThan(value: false, name: TABLET), // 태블릿보다 크면 안보인다.
          ],
          child: IconButton(
            onPressed: () {
              //
            },
            icon: Icon(Icons.menu),
          ),
        ),
        actions: [
          ResponsiveVisibility(
            hiddenConditions: [Condition.largerThan(value: true, name: MOBILE)],
            child: MenuTextButton(text: 'Courses'),
          ),
          ResponsiveVisibility(
            hiddenConditions: [Condition.largerThan(value: true, name: MOBILE)],
            child: MenuTextButton(text: 'About'),
          ),
          IconButton(
            onPressed: () {
              //
            },
            icon: Icon(Icons.mark_email_unread_rounded),
          ),
          IconButton(
            onPressed: () {
              //
            },
            icon: Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: ListView(
        children: [
          Center(child: PageHeader()),
          SizedBox(height: 30),
          ResponsiveRowColumn(
            rowMainAxisAlignment: MainAxisAlignment.center,
            rowPadding: EdgeInsets.all(30),
            columnPadding: EdgeInsets.all(30),
            layout:
                ResponsiveBreakpoints.of(context).isDesktop
                    ? ResponsiveRowColumnType.ROW
                    : ResponsiveRowColumnType.COLUMN,
            children: [
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: CourseTitle(course: courses[0]),
              ),
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: CourseTitle(course: courses[1]),
              ),
            ],
          ),
          SizedBox(height: 20),
          Center(child: SubscribeBlock()),
        ],
      ),
    );
  }
}
