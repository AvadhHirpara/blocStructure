import 'dart:math' as math;

import 'package:flutter/material.dart';

const Color colorPrimary = Color(0xFFFFFFFF);
const Color colorTransparent = Colors.transparent;
const Color colorBlack = Color(0xFF000000);
const Color colorWhite = Color(0xFFFFFFFF);
const Color colorFF0000 = Color(0xFFFF0000); //Red
const Color colorGreen = Color(0xFF2E7C22);
const Color color1D1E20 = Color(0xFF1D1E20);
const Color colorFBBC05 = Color(0xFFFBBC05);
const Color colorF47719 = Color(0xFFF47719);
const Color colorED2730 = Color(0xFFED2730);
const Color colorECECEC = Color(0xFFECECEC);
const Color colorEBEBEB = Color(0xFFEBEBEB);
const Color color051315 = Color(0xFF051315);
const Color colorDDDDDD = Color(0xFFDDDDDD);
const Color color8F959E = Color(0xFF8F959E);
const Color color181818 = Color(0xFF181818);
const Color colorEB4335 = Color(0xFFEB4335);
const Color colorFCE8E9 = Color(0xFFFCE8E9);
const Color colorEEEEEE = Color(0xFFEEEEEE);
const Color color8E8E8E = Color(0xFF8E8E8E);
const Color colorF1F1F1 = Color(0xFFF1F1F1);
const Color colorFAFAFA = Color(0xFFFAFAFA);
const Color color838383 = Color(0xFF838383);
const Color colorDADADA = Color(0xFFDADADA);
const Color colorFFC700 = Color(0xFFFFC700);
const Color colorF3F3F3 = Color(0xFFF3F3F3);
const Color color4BC76D = Color(0xFF4BC76D);
const Color color7C7C7C = Color(0xFF7C7C7C);
const Color colorEFEFEF = Color(0xFFEFEFEF);
const Color colorDFDFDF = Color(0xFFDFDFDF);
const Color colorF8F8F8 = Color(0xFFF8F8F8);
const Color color555555 = Color(0xFF555555);
const Color color6A6A6A = Color(0xFF6A6A6A);
const Color colorC2C2C2 = Color(0xFFC2C2C2);
const Color color151515 = Color(0xFF151515);
const Color colorE2E2E2 = Color(0xFFE2E2E2);
const Color colorAE8E1E = Color(0xFFAE8E1E);
const Color colorA3A3A3 = Color(0xFFA3A3A3);
const Color colorA87A00 = Color(0xFFA87A00);
const Color color0066FF = Color(0xFF0066FF);
const Color color257305 = Color(0xFF257305);
const Color color797979 = Color(0xFF797979);
const Color colorE7E7E7 = Color(0xFFE7E7E7);
const Color colorD3D1D8 = Color(0xFFD3D1D8);
const Color color14181B = Color(0xFF14181B);
const Color colorBottomLabel = Color.fromRGBO(241, 45, 20, 1);

List<Color> fillGradient = [colorED2730, colorF47719];
List<Color> fillGradientBorder = [colorED2730.withOpacity(0.4), colorFBBC05.withOpacity(0.4)];
List<Color> gradient1D1E20W30 = [color1D1E20.withOpacity(0.3), color1D1E20.withOpacity(0.3)];

Gradient gradientBlackStream = LinearGradient(
  colors: [
    Colors.black.withOpacity(0),
    Colors.black.withOpacity(0),
    Colors.black.withOpacity(0),
    Colors.black.withOpacity(0.6),
    Colors.black.withOpacity(0.8),
    Colors.black,
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

Gradient gradientEEEEEE = const LinearGradient(colors: [colorEEEEEE, colorEEEEEE]);

Gradient gradientPrimary = const LinearGradient(
  begin: Alignment(0, -0.6),
  end: Alignment(0.1, 4),
  colors: [
    Color.fromRGBO(237, 39, 48, 1),
    Color.fromRGBO(251, 188, 5, 1),
  ],
  transform: GradientRotation(math.pi - 550),
);
