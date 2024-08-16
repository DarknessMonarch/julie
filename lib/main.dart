import 'package:jolie/common.dart';
import 'package:jolie/screens/splash.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  // root of the app
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Jolie house of beauty",
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}

