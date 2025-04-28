import 'package:flutter/material.dart';
import 'package:flutter_scene/scene.dart';

import 'dart:math';
import 'package:vector_math/vector_math.dart' as vm;

class ExampleCar extends StatefulWidget {
  const ExampleCar({super.key, this.elapsedSeconds = 4});

  final double elapsedSeconds;

  @override
  State<ExampleCar> createState() => _ExampleCarState();
}

class NodeState {
  NodeState(this.node, this.startTransform);

  Node node;
  vm.Matrix4 startTransform;
  double amount = 0;
}

class _ExampleCarState extends State<ExampleCar> {
  Scene scene = Scene();
  bool loaded = false;

  Map<String, NodeState> nodes = {};

  @override
  void initState() {
    debugPrint('init car');
    final loadModel = Node.fromAsset('build/models/fcar.model').then((value) {
      value.name = 'car';
      scene.add(value);
    });

    Future.wait([loadModel]).then((_) {
      debugPrint('scene loaded');
      setState(() {
        loaded = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      debugPrint('hier rein');
      return const Center(child: CircularProgressIndicator());
    }
    return Stack(
      children: [
        SizedBox.expand(
          child: CustomPaint(
            painter: _ScenePainter(scene, widget.elapsedSeconds),
          ),
        ),
      ],
    );
  }
}

class _ScenePainter extends CustomPainter {
  _ScenePainter(this.scene, this.elapsedTime);

  Scene scene;
  double elapsedTime;

  @override
  void paint(Canvas canvas, Size size) {
    double rotationAmount = elapsedTime * 0.2;
    final camera = PerspectiveCamera(
      position:
          vm.Vector3(sin(rotationAmount) * 5, 2, cos(rotationAmount) * 5) * 2,
      target: vm.Vector3(0, 0, 0),
    );

    scene.render(camera, canvas, viewport: Offset.zero & size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
