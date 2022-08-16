import 'package:flutter/material.dart';
import 'package:progress_bar_circular_app/widgets/radial_progress.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//------------------ Variables ------------------------
  double porcentaje = 0.0;

//------------------- Pantalla -----------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Circular Progress Bar'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _CustomRadialProgress(
                porcentaje: porcentaje * 0.3,
                color: Colors.blue,
              ),
              _CustomRadialProgress(
                porcentaje: porcentaje,
                color: Colors.red,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _CustomRadialProgress(
                porcentaje: porcentaje * 0.8,
                color: Colors.yellow,
              ),
              _CustomRadialProgress(
                porcentaje: porcentaje * 0.2,
                color: Colors.green,
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.refresh,
        ),
        onPressed: () {
          setState(() {
            porcentaje += 10;
            if (porcentaje > 100) {
              porcentaje = 0;
              porcentaje = 0;
            }
          });
        },
      ),
    );
  }
}

//-------------------- _CustomRadialProgress ------------------
class _CustomRadialProgress extends StatelessWidget {
  final color;

  const _CustomRadialProgress({
    Key? key,
    required this.porcentaje,
    required this.color,
  }) : super(key: key);

  final double porcentaje;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      child: Center(
        child: RadialProgress(
          porcentaje: porcentaje,
          colorPrimario: color,
          colorSecundario: Colors.grey,
          grosorPrimario: 15,
          grosorSecundario: 5,
        ),
      ),
    );
  }
}
