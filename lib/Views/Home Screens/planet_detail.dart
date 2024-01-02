import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Model/planet_variable.dart';

class PlanetDetail extends StatefulWidget {
  final allPlanets planets;

  const PlanetDetail({Key? key, required this.planets}) : super(key: key);

  @override
  State<PlanetDetail> createState() => _PlanetDetailState();
}

class _PlanetDetailState extends State<PlanetDetail>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController rocketController;
  late Animation<double> rocket;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    rocketController = AnimationController(
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
      duration: const Duration(seconds: 5),
    )..repeat();

    rocket = Tween<double>(
      begin: -150,
      end: 0,
    ).animate(rocketController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    rocket = Tween<double>(
      begin: -210,
      end: MediaQuery.of(context).size.width + 100,
    ).animate(rocketController);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
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
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      CupertinoIcons.back,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
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
                "${widget.planets.lightYears} LIGHT YEARS / ${widget.planets.distancekm} Kms",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Transform.translate(
                offset: Offset(rocket.value, 0),
                child: const Icon(
                  CupertinoIcons.rocket,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              _buildInfoContainer(
                Icons.speed,
                "Average Orbital Speed",
                "${widget.planets.velocity} Km/s",
              ),
              const SizedBox(height: 30),
              _buildInfoContainer(
                Icons.satellite_alt_sharp,
                "Satellites",
                "${widget.planets.Sattelites}",
              ),
              const SizedBox(height: 30),
              _buildInfoContainer(
                Icons.speed,
                "Position",
                "${widget.planets.Position}",
              ),
              const SizedBox(height: 30),
              _buildDescriptionContainer(
                "Description",
                widget.planets.description,
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoContainer(IconData icon, String title, String subtitle) {
    return Container(
      height: 70,
      width: 400,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        boxShadow: [
          const BoxShadow(
              spreadRadius: 0, color: Colors.white, blurRadius: 10),
        ],
        color: const Color(0xff0B194B),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.white,
          size: 35,
          shadows: [
            Shadow(blurRadius: 25),
          ],
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildDescriptionContainer(String title, String description) {
    return SingleChildScrollView(
      child: Container(
        height: 360,
        width: 400,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          boxShadow: [
            const BoxShadow(spreadRadius: 0, color: Colors.white, blurRadius: 10)
          ],
          color: const Color(0xff0B194B),
          borderRadius: BorderRadius.circular(30),
        ),
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            description,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
