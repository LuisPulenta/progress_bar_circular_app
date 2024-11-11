import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

class CircularProgressScreen extends StatefulWidget {
  const CircularProgressScreen({Key? key}) : super(key: key);

  @override
  State<CircularProgressScreen> createState() => _CircularProgressScreenState();
}

class _CircularProgressScreenState extends State<CircularProgressScreen>
    with SingleTickerProviderStateMixin {
  //------------------ Variables ------------------------
  double porcentaje = 0.0;
  double nuevoPorcentaje = 0.0;
  late AnimationController controller;

  //------------------- initState -----------------------
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    controller.addListener(() {
      porcentaje = lerpDouble(porcentaje, nuevoPorcentaje, controller.value)!;
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

//------------------- Pantalla -----------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(5),
          width: 300,
          height: 300,
          child: CustomPaint(
            painter: _MiRadialProgress(porcentaje),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: const Icon(
          Icons.refresh,
        ),
        onPressed: () {
          porcentaje = nuevoPorcentaje;
          nuevoPorcentaje = nuevoPorcentaje + 10;
          if (nuevoPorcentaje > 100) {
            nuevoPorcentaje = 0;
            porcentaje = 0;
          }
          controller.forward(from: 0.0);
          setState(() {});
        },
      ),
    );
  }
}

//----------------- _MiRadialProgress ----------------------
class _MiRadialProgress extends CustomPainter {
  final double porcentaje;

  _MiRadialProgress(this.porcentaje);

  @override
  void paint(Canvas canvas, Size size) {
    //Círculo completado
    final paint = Paint()
      ..strokeWidth = 4
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    Offset center = Offset(size.width * 0.5, size.height * 0.5);
    double radio = min(size.width, size.height) * 0.5;

    canvas.drawCircle(center, radio, paint);

    //Arco
    final paintArco = Paint()
      ..strokeWidth = 10
      ..color = Colors.red
      ..style = PaintingStyle.stroke;

    //Parte que se debe llenar
    double arcAngle = 2 * pi * (porcentaje / 100);
    Rect rect = Rect.fromCircle(center: center, radius: radio);

    canvas.drawArc(rect, -pi / 2, arcAngle, false, paintArco);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
