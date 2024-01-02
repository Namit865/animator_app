import 'dart:convert';
import 'dart:math';
import 'package:animator_app/Helper/theme_provider.dart';
import 'package:animator_app/Model/planet_variable.dart';
import 'package:animator_app/Views/Home%20Screens/planet_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  List<allPlanets> allDetails = [];
  int currentIndex = 0;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
    planetFetch();
    _pageController = PageController(initialPage: currentIndex);
  }

  planetFetch() async {
    String jsonString = await rootBundle.loadString("asset/planet.json");
    Map data = jsonDecode(jsonString);
    List? planets = data['planets'];
    setState(() {});
    if (planets != null) {
      allDetails = planets
          .map(
            (e) => allPlanets(
          name: e['name'].toString(),
          image: e['image'].toString(),
          description: e['description'].toString(),
          distance: (e['distance_km']),
          Position: (e['position']),
          velocity: (e['velocity']),
          temprature: (e['temp'],).toString().replaceAll(',', ''),
          lightYears: e['distance_light_years'],
          distancekm: e['distance_km'],
          Sattelites: e['satellite'],
        ),
      )
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("asset/images/space.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemCount: allDetails.length,
              itemBuilder: (BuildContext context, int index) {
                allPlanets e = allDetails[index];
                return _buildPage(e);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(allPlanets e) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          _pageController.animateToPage(
            currentIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 40),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        "Claire Maiden",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      Provider.of<themeProvider>(context, listen: false)
                          .themeToggle();
                    },
                    icon: const Icon(Icons.dark_mode, size: 30),
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10,),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image: AssetImage("asset/images/Fortnite.jpg"),
                            fit: BoxFit.cover),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 100),
            _buildPageIndicators(),
            const SizedBox(
              height: 50,
            ),
            Text(
              e.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 100,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlanetDetail(planets: e),
                  ),
                );
              },
              child: SizedBox(
                height: 450,
                width: 500,
                child: Hero(
                  tag: 'planetImage${e.image}',
                  child: RotationTransition(
                    turns: Tween(begin: 0.0, end: 1.0)
                        .animate(animationController),
                    child: Transform.rotate(
                      angle: pi / 2,
                      child: Image.asset(
                        e.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        9,
            (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: 15,
          width: 30,
          decoration: BoxDecoration(
            color: currentIndex == index ? Colors.white : Colors.white38,
            shape: BoxShape.circle,
          ),
          margin: EdgeInsets.symmetric(
              horizontal: currentIndex == index
                  ? 0
                  : MediaQuery.of(context).devicePixelRatio),
        ),
      ),
    );
  }
}
