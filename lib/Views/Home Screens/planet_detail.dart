import 'package:animator_app/Model/planet_variable.dart';
import 'package:flutter/material.dart';

class PlanetDetail extends StatefulWidget {
  final allPlanets planets;

  PlanetDetail({super.key, required this.planets});

  @override
  State<PlanetDetail> createState() => _PlanetDetailState();
}

class _PlanetDetailState extends State<PlanetDetail>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("asset/images/space.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Text(
                  widget.planets.name,
                  style: const TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Hero(
                  tag: 'planetImage${widget.planets.image}',
                  child: RotationTransition(
                    turns: Tween(begin: 0.0, end: 1.0)
                        .animate(animationController),
                    child: Image.asset(widget.planets.image, fit: BoxFit.cover),
                  ),
                ),
                const Text(
                  "Distance From Earth",
                  style: TextStyle(fontSize: 16, color: Colors.white60),
                ),
                const SizedBox(height: 5,),
                Text(
                  "${widget.planets.lightYears} LIGHT YEAR",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Positioned(
              right: 60,
              top: 150,
              child: Container(
                alignment: Alignment.center,
                height: 80,
                width: 80,
                decoration: const BoxDecoration(
                  color: Colors.black45,
                  shape: BoxShape.circle,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.thermostat_rounded,
                        color: Colors.white,
                      ),
                      Text(
                        "${widget.planets.temprature}°C",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
