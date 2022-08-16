import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

class RadialProgress extends StatefulWidget {
  final double porcentaje;
  final Color colorPrimario;
  final Color colorSecundario;
  final double grosorPrimario;
  final double grosorSecundario;

  RadialProgress(
      {required this.porcentaje,
      this.colorPrimario = Colors.blue,
      this.colorSecundario = Colors.yellow,
      this.grosorPrimario = 10,
      this.grosorSecundario = 20});

  @override
  State<RadialProgress> createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  //------------------ Variables ------------------------

  late AnimationController controller;
  late double porcentajeAnterior;

  //------------------- initState -----------------------
  @override
  void initState() {
    porcentajeAnterior = widget.porcentaje;

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    controller.dispose();
  }

//------------------- Pantalla -----------------------

  @override
  Widget build(BuildContext context) {
    controller.forward(from: 0.0);
    final diferenciaAnimar = widget.porcentaje - porcentajeAnterior;
    porcentajeAnterior = widget.porcentaje;

    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: _MiRadialProgress(
                (widget.porcentaje - diferenciaAnimar) +
                    (diferenciaAnimar * controller.value),
                widget.colorPrimario,
                widget.colorSecundario,
                widget.grosorPrimario,
                widget.grosorSecundario),
          ),
        );
      },
    );
  }
}

//----------------- _MiRadialProgress ----------------------
class _MiRadialProgress extends CustomPainter {
  final double porcentaje;
  final Color colorPrimario;
  final Color colorSecundario;
  final double grosorPrimario;
  final double grosorSecundario;

  _MiRadialProgress(this.porcentaje, this.colorPrimario, this.colorSecundario,
      this.grosorPrimario, this.grosorSecundario);

  @override
  void paint(Canvas canvas, Size size) {
    //Para aplicar un gradiente
    final Gradient gradiente = LinearGradient(
        colors: <Color>[Color(0xffc012ff), Color(0xff1205e8), Colors.orange]);

    final Rect rect = Rect.fromCircle(center: Offset(0, 0), radius: 180);

    //Círculo completado
    final paint = Paint()
      ..strokeWidth = grosorSecundario
      ..color = colorSecundario
      ..style = PaintingStyle.stroke;

    Offset center = Offset(size.width * 0.5, size.height * 0.5);
    double radio = min(size.width, size.height) * 0.5;

    canvas.drawCircle(center, radio, paint);

    //Arco
    final paintArco = Paint()
      ..strokeWidth = grosorPrimario
      //..color = colorPrimario
      ..shader = gradiente.createShader(rect)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    //Parte que se debe llenar
    double arcAngle = 2 * pi * (porcentaje / 100);
    Rect rectCircle = Rect.fromCircle(center: center, radius: radio);

    canvas.drawArc(rectCircle, -pi / 2, arcAngle, false, paintArco);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
