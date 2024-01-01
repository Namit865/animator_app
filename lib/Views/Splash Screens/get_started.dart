import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Home Screens/homescreen.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("asset/images/getstarted.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60, left: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "EXPLORE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Text(
                "SOLAR",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "SYSTEM",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () async {
                  SharedPreferences prefs =
                  await SharedPreferences.getInstance();
                  prefs.setBool('isViewed', true);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (Acontext) => HomeScreen(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.arrow_forward,
                  size: 28,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
