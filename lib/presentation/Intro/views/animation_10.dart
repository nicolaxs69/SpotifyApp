import 'dart:math';
import 'package:flutter/material.dart';
import 'package:refresh_flutter/presentation/Intro/views/custom_painter.dart';

class Animation10 extends StatefulWidget {
  const Animation10({Key? key}) : super(key: key);

  @override
  _Animation10State createState() => _Animation10State();
}

class _Animation10State extends State<Animation10> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

 double _fillLevel = 0.5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 2)
    );
    _animationController.repeat();
  }
  
  @override
  void dispose(){
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation 10"),
      ),
      body: Center(child: _buildBody()),

    );
  }

  Widget _buildBody() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          width: 250,
          height: 250,
          child: CustomPaint(
            painter: RPSCustomPainter(
              animationValue: _animationController.value
            ),
          ),
        );
      },
    );
  }
}