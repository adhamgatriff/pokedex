import 'package:flutter/material.dart';

class LoaderAnimation extends StatefulWidget {
  @override
  _LoaderAnimationState createState() => _LoaderAnimationState();
}

class _LoaderAnimationState extends State<LoaderAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 7),
    );

    _controller.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: AnimatedBuilder(
        animation: _controller,
        child: Container(
          height: 150.0,
          width: 150.0,
          child: Image.asset('assets/cyndaquil.png'),
        ),
        builder: (BuildContext context, Widget _widget) {
          return Transform.rotate(
            angle: _controller.value * 6.3,
            child: _widget,
          );
        },
      ),
    );
  }
}