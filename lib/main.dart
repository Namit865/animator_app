import 'package:animator_app/Helper/theme_provider.dart';
import 'package:animator_app/Views/Splash%20Screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final bool res = preferences.getBool('isViewd') ?? true;
  runApp(
    MyApp(isViewd: res),
  );
}

class MyApp extends StatelessWidget {
  final bool isViewd;

  MyApp({super.key, required this.isViewd});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => themeProvider(),
        )
      ],
      builder: (context, child) => MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: Provider.of<themeProvider>(context).Theme.isdark?ThemeMode.light:ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
