import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    // Esquema de cores principal (agora em modo 'light')
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.black, // O "seed" agora é preto para gerar tons de cinza
      brightness: Brightness.light,
      primary: Colors.black,             // Cor primária para textos e ícones importantes
      background: const Color(0xFFFFFFFF), // Fundo branco puro
      surface: const Color(0xFFFFFFFF),   // Superfície para cards (cinza muito claro)
      onPrimary: Colors.white,            // Cor sobre a cor primária (ex: em botões)
      onBackground: Colors.black,         // Cor do texto sobre o fundo
      onSurface: Colors.black,            // Cor do texto sobre as superfícies
    ),

    // Define o fundo padrão para todas as telas
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),

    // Tema para a AppBar (barra superior)
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFFFFFF), // Fundo branco
      foregroundColor: Colors.black,       // Título e ícones em preto
      elevation: 0, // Sem sombra para um visual limpo
      surfaceTintColor: Colors.transparent, // Remove a tonalidade automática do Material 3
    ),

    // Tema para o BottomNavigationBar (menu inferior)
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFFFFFFF),
      selectedItemColor: Colors.black,       // Ícone selecionado em preto
      unselectedItemColor: Colors.grey,    // Ícone não selecionado em cinza
      showUnselectedLabels: false,
      elevation: 0,
      type: BottomNavigationBarType.fixed, // Garante que o fundo seja sempre o definido
    ),

    // Tema para Botões Elevados (se você usar)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black, // Botões com fundo preto
        foregroundColor: Colors.white, // Texto branco
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Cantos menos arredondados, mais "Apple"
        ),
      ),
    ),

    // Tema para Textos
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black87, height: 1.5), // Aumenta o espaçamento entre linhas
    ),

    useMaterial3: true,
  );
}