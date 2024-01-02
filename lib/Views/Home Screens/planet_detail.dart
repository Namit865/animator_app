import 'package:animator_app/Model/planet_variable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlanetDetail extends StatefulWidget {
  final allPlanets planets;

  const PlanetDetail({Key? key, required this.planets}) : super(key: key);

  @override
  State<PlanetDetail> createState() => _PlanetDetailState();
}

class _PlanetDetailState extends State<PlanetDetail>
    with TickerProviderStateMixin {
  List<allPlanets> Data = [];
  late AnimationController animationController;
  late AnimationController rocketcontroller;
  late Animation<double> rocket;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    rocketcontroller = AnimationController(
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
      duration: const Duration(seconds: 5),
    )..repeat();

    rocket = Tween<double>(
      begin: -150,
      end: 0,
    ).animate(rocketcontroller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    rocket = Tween<double>(
      begin: -210,
      end: MediaQuery.of(context).size.width + 100,
    ).animate(rocketcontroller)
      ..addListener(() {
        setState(() {});
      });

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("asset/images/space.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Text(
                widget.planets.name,
                style: const TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Hero(
                tag: 'planetImage${widget.planets.name}',
                child: RotationTransition(
                  turns:
                      Tween(begin: 0.0, end: 1.0).animate(animationController),
                  child: Image.asset(widget.planets.image, fit: BoxFit.cover),
                ),
              ),
              const Text(
                "Distance From Earth",
                style: TextStyle(fontSize: 16, color: Colors.white60),
              ),
              const SizedBox(height: 5),
              Text(
                "${widget.planets.lightYears} LIGHT YEARS",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Transform.translate(
                offset: Offset(rocket.value, 0),
                child: const Icon(
                  CupertinoIcons.rocket,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 70,
                width: 400,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color(0xff0B194B),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.speed,
                    color: Colors.white,
                    size: 35,
                    shadows: [
                      Shadow(blurRadius: 25),
                    ],
                  ),
                  title: const Text(
                    "Average Orbital Speed",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  subtitle: Text(
                    "${widget.planets.velocity} Km/s",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              Container(
                height: 70,
                width: 400,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color(0xff0B194B),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const ListTile(
                  leading: Icon(Icons.speed,
                      color: Colors.white,
                      size: 35,
                      shadows: [Shadow(blurRadius: 25)]),
                ),
              ),
              Container(
                height: 70,
                width: 400,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color(0xff0B194B),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const ListTile(
                  leading: Icon(Icons.speed,
                      color: Colors.white,
                      size: 35,
                      shadows: [Shadow(blurRadius: 25)]),
                ),
              ),
              Container(
                height: 70,
                width: 400,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color(0xff0B194B),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const ListTile(
                  leading: Icon(Icons.speed,
                      color: Colors.white,
                      size: 35,
                      shadows: [Shadow(blurRadius: 25)]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
