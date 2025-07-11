import 'package:flutter/material.dart';

class InitialTab extends StatelessWidget {
  const InitialTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Aqui virá o conteúdo da sua tela inicial (dashboard, etc.)
    return const Center(
      child: Text('Tela Inicial', style: TextStyle(fontSize: 24)),
    );
  }
}