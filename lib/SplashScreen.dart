import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kecconnect/HomePage.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation _animation;
  @override
  void initState()
  {
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse:true);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
    super.initState();
    Timer(Duration(seconds: 3),()=>Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const HomePage(),
      ),
    ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _animation as Animation<double>,

          child: Image.asset("images/logo-color.png",
            height: 320,width: MediaQuery.of(context).size.width*0.75,
          ),
        ),
      ),
    );
  }
}