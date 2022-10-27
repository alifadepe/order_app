import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class ThemeConfig {
  ThemeConfig._();

  static ThemeData mainThemeData() {
    return ThemeData(
      colorScheme: _colorScheme,
      textTheme: _textTheme,
      primaryColor: _colorScheme.primary,
      appBarTheme: AppBarTheme(
        backgroundColor: _colorScheme.primary,
        foregroundColor: _colorScheme.onPrimary,
        elevation: 4,
        iconTheme: IconThemeData(color: _colorScheme.onPrimary),
      ),
      iconTheme: IconThemeData(color: _colorScheme.primary),
      canvasColor: _colorScheme.background,
      scaffoldBackgroundColor: _colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: _focusColor,
      scrollbarTheme: const ScrollbarThemeData(
        isAlwaysShown: true,
        radius: Radius.circular(8),
      ),
    );
  }

  static ColorScheme get _colorScheme => ColorScheme(
        primary: HexColor("#F4B755"),
        primaryVariant: HexColor("#F4B755"),
        secondary: HexColor("#21252a"),
        secondaryVariant: HexColor("#21252a"),
        background: const Color(0xFFFFFFFF),
        surface: const Color(0xFFFFFFFF),
        onBackground: Colors.black,
        error: HexColor("#D32F2F"),
        onError: Colors.white,
        onPrimary: Colors.black,
        onSecondary: const Color(0xFF322942),
        onSurface: const Color(0xFF241E30),
        brightness: Brightness.light,
      );

  static final _fillColor = HexColor("#21252a");
  static final _focusColor = Colors.black.withOpacity(0.12);

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static final TextTheme _textTheme = TextTheme(
    headline1: GoogleFonts.poppins(
      fontWeight: _bold,
      fontSize: 24.0,
      color: _fillColor,
    ),
    headline2: GoogleFonts.poppins(
      fontWeight: _bold,
      fontSize: 22.0,
      color: _fillColor,
    ),
    headline3: GoogleFonts.poppins(
      fontWeight: _bold,
      fontSize: 20.0,
      color: _fillColor,
    ),
    headline4: GoogleFonts.poppins(
      fontWeight: _bold,
      fontSize: 18.0,
      color: _fillColor,
    ),
    headline5: GoogleFonts.poppins(
      fontWeight: _medium,
      fontSize: 16.0,
      color: _fillColor,
    ),
    headline6: GoogleFonts.poppins(
      fontWeight: _bold,
      fontSize: 16.0,
      color: _fillColor,
    ),
    subtitle1: GoogleFonts.poppins(
      fontWeight: _medium,
      fontSize: 16.0,
      color: _fillColor,
    ),
    subtitle2: GoogleFonts.poppins(
      fontWeight: _medium,
      fontSize: 14.0,
      color: _fillColor,
    ),
    bodyText1: GoogleFonts.poppins(
      fontWeight: _regular,
      fontSize: 14.0,
      color: _fillColor,
    ),
    bodyText2: GoogleFonts.poppins(
      fontWeight: _regular,
      fontSize: 16.0,
      color: _fillColor,
    ),
    button: GoogleFonts.poppins(
      fontWeight: _semiBold,
      fontSize: 14.0,
      color: _fillColor,
    ),
    caption: GoogleFonts.poppins(
      fontWeight: _semiBold,
      fontSize: 16.0,
      color: _fillColor,
    ),
    overline: GoogleFonts.poppins(
      fontWeight: _medium,
      fontSize: 12.0,
      color: _fillColor,
    ),
  );
}
