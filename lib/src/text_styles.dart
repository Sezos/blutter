import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum TextSize { m, s, l, xl, xs, x2l, x3l, x2s, x3s }

double textSizeToDouble(TextSize size) {
  switch (size) {
    case TextSize.x3s:
      return 6;
    case TextSize.x2s:
      return 8;
    case TextSize.xs:
      return 10;
    case TextSize.s:
      return 12;

    case TextSize.l:
      return 17;
    case TextSize.xl:
      return 20;
    case TextSize.x2l:
      return 23;
    case TextSize.x3l:
      return 26;
    default:
      return 14;
  }
}

class BText extends StatelessWidget {
  final String title;
  final Color? color;
  final TextSize size;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int maxLine;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final double? decorationThickness;

  const BText(
    this.title, {
    this.color,
    this.size = TextSize.m,
    this.fontWeight,
    this.textAlign,
    this.maxLine = 0,
    this.overflow,
    this.decoration,
    this.decorationColor,
    this.decorationThickness,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.overpass(
        fontSize: textSizeToDouble(size),
        color: color,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationThickness: decorationThickness,
        fontWeight:
            fontWeight == FontWeight.bold ? FontWeight.w500 : fontWeight,
      ),
      overflow: overflow,
      maxLines: maxLine == 0 ? null : maxLine,
      textAlign: textAlign,
    );
  }
}

class BTitle extends StatelessWidget {
  final String title;
  final Color? color;
  final TextSize size;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int maxLine;
  final TextOverflow? overflow;

  const BTitle(
    this.title, {
    this.color,
    this.size = TextSize.x3l,
    this.fontWeight = FontWeight.w900,
    this.textAlign,
    this.maxLine = 0,
    this.overflow,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.overpass(
        fontSize: textSizeToDouble(size),
        color: color,
        fontWeight:
            fontWeight == FontWeight.bold ? FontWeight.w500 : fontWeight,
      ),
      overflow: overflow,
      maxLines: maxLine == 0 ? null : maxLine,
      textAlign: textAlign,
    );
  }
}

class BSubtitle extends StatelessWidget {
  final String title;
  final Color? color;
  final TextSize size;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int maxLine;
  final TextOverflow? overflow;

  const BSubtitle(
    this.title, {
    this.color,
    this.size = TextSize.l,
    this.fontWeight = FontWeight.bold,
    this.textAlign,
    this.maxLine = 0,
    this.overflow,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.overpass(
        fontSize: textSizeToDouble(size),
        color: color,
        fontWeight:
            fontWeight == FontWeight.bold ? FontWeight.w500 : fontWeight,
      ),
      overflow: overflow,
      maxLines: maxLine == 0 ? null : maxLine,
      textAlign: textAlign,
    );
  }
}

extension StringCasingExtension on String {
  String get toCapitalized =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
}
