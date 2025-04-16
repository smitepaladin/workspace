import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_login_app/view/second_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  // Observer추가,shared preferences를 쓰기 위해서. 이걸 안 쓰면 유저 아이디 패스워드가 다 노출된다.

  // Property
  late TextEditingController userIdController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    userIdController = TextEditingController();
    passwordController = TextEditingController();
    // Shared preference 초기화
    initSharedPreferences();
  }

  initSharedPreferences() async {
    final prefs =
        await SharedPreferences.getInstance(); // 원래 인스턴스는 메모리에 남아있는데 sharedpreperences는 사라진다
    userIdController.text = prefs.getString('p_userId') ?? "";
    passwordController.text = prefs.getString('p_password') ?? "";
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        print('detached');
      case AppLifecycleState.resumed:
        print('resumed');
      case AppLifecycleState.inactive:
        disposesharedPreferences();
        print('inactive');
      case AppLifecycleState.paused:
        print('Paused');
      default:
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  disposesharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    prefs.remove('p_password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('images/login.png'),
              radius: 70,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: userIdController,
                decoration: InputDecoration(labelText: '아이디를 입력하세요'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: '패스워드를 입력하세요'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (userIdController.text.trim().isEmpty ||
                    passwordController.text.trim().isEmpty) {
                  errorSnackBar();
                } else {
                  _showDialog();
                }
              },
              child: Text('Log In'),
            ),
          ],
        ),
      ),
    );
  } //Build

  // Functions //

  errorSnackBar() {
    Get.snackbar(
      '경고',
      '사용자 ID와 암호를 입력하세요',
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
      colorText: Theme.of(context).colorScheme.onError,
      backgroundColor: Theme.of(context).colorScheme.onError,
    );
  }

  _showDialog() {
    Get.defaultDialog(
      title: '환영합니다',
      middleText: '신분이 확인되었습니다.',
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            saveSharedPreferences();
            Get.to(SecondPage());
          },
          child: Text('Exit'),
        ),
      ],
    );
  }

  saveSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('p_userId', userIdController.text);
    prefs.setString('p_password', passwordController.text);
  }
} //Class
