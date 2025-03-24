import 'package:flutter/material.dart';

class MyMessage extends StatelessWidget {
  const MyMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed:
                () => snackBarFunction(
                  context,
                  'Elevated Button is clicked.',
                  Colors.red,
                  5,
                ), // 파라미터를 넣어준다.
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Text(
              'Snackbar Button',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed:
                () => snackBarFunction(
                  context,
                  'Elevated Button is clicked.',
                  Colors.red,
                  5,
                ), // 파라미터를 넣어준다.
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Text(
              'Snackbar Button',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed:
                () => snackBarFunction(
                  context,
                  'Elevated Button is clicked.',
                  Colors.red,
                  5,
                ), // 파라미터를 넣어준다.
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Text(
              'Snackbar Button',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed:
                () => snackBarFunction(
                  context,
                  '버튼이 눌렸습니다.',
                  Colors.blue,
                  2,
                ), // 파라미터를 넣어준다.
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Text(
              'Snackbar Button',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  } // Build

  // -------- Function -------- //
  snackBarFunction(
    BuildContext context,
    String message,
    Color colors,
    int dura,
  ) {
    // 파라미터를 넣어줄 뿐만아니라 타입도 넣어준다.
    ScaffoldMessenger.of(context).showSnackBar(
      // of(context)는 context에 메모리 공간을 만든다. 여기서는 showSnackBar의 메모리공간을 말한다.
      SnackBar(
        content: Text(message, style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: colors,
        duration: Duration(seconds: dura),
      ),
    );
  }
} // MyMessage