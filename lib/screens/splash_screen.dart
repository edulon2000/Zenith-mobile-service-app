import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth/auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulsingAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleOutAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // ---- ADICIONE ESTE OUVINTE DE STATUS ----
    // Este listener será chamado sempre que o status da animação mudar (ex: concluída)
    _controller.addStatusListener((status) {
      // Se a animação de saída foi completada...
      if (status == AnimationStatus.completed) {
        // ...navega para a HomeScreen, substituindo a SplashScreen
        Navigator.of(context).pushReplacementNamed('/home');
      }
    });
    // ------------------------------------------

    // O resto das definições de animação continua igual
    _pulsingAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.1), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 1.1, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _rotationAnimation = Tween<double>(begin: 0.0, end: pi / 2).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.5, curve: Curves.easeIn))
    );
    _scaleOutAnimation = Tween<double>(begin: 1, end: 50).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1.0, curve: Curves.easeOut))
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // O BlocListener aqui continua com a mesma função: iniciar a animação de saída
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          _controller.stop();
          _controller.forward();
        }
      },
      child: Scaffold(
        body: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              return Transform.scale(
                scale: _scaleOutAnimation.value,
                child: Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: Transform.scale(
                    scale: _pulsingAnimation.value,
                    child: child,
                  ),
                ),
              );
            },
            child: Text(
              'Z',
              style: TextStyle(
                fontSize: 100,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
    );
  }
}