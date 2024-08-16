import 'dart:async';
import 'package:jolie/common.dart';
import 'package:jolie/screens/Home/home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  loading() {
    Timer(const Duration(seconds: 10), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    });
  }

  @override
  void initState() {
    super.initState();
    loading();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: primaryColor,
        body: Center(
            child: Image(
          image: AssetImage("assets/images/logo.png"),
          height: 200.0,
        )));
  }
}
