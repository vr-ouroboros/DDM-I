import 'package:flutter/material.dart';

/// Cores de identidade visual do Brasa.
abstract final class BrasaCores {
  static const vermelho = Color(0xFFDC4E48);
  static const vermelhoEscuro = Color(0xFFAD3934);
  static const amarelo = Color(0xFFF5BE67);
  static const creme = Color(0xFFFFF9F5);
  static const rosa = Color(0xFFFFF0EF);
  static const texto = Color(0xFF292527);
  static const secundario = Color(0xFF796D6B);
  static const borda = Color(0xFFF0DEDA);
  static const branco = Colors.white;
}

abstract final class BrasaTheme {
  static ThemeData get claro => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: BrasaCores.creme,
    colorScheme: ColorScheme.fromSeed(seedColor: BrasaCores.vermelho).copyWith(
      primary: BrasaCores.vermelho,
      onPrimary: BrasaCores.branco,
      secondary: BrasaCores.amarelo,
      surface: BrasaCores.branco,
      onSurface: BrasaCores.texto,
    ),
    textTheme: ThemeData.light().textTheme.apply(
      bodyColor: BrasaCores.texto,
      displayColor: BrasaCores.texto,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: BrasaCores.texto,
      contentTextStyle: TextStyle(color: BrasaCores.branco),
      behavior: SnackBarBehavior.floating,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: BrasaCores.branco,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: BrasaCores.borda),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: BrasaCores.borda),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: BrasaCores.vermelho, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
    ),
  );
}
