import 'package:flutter/widgets.dart';

class Suits {
  Suits._();

  static const _kFontFam = 'Suits';
  static const String? _kFontPkg = null;

  static const IconData clubs = IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData dice = IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData hearts = IconData(0xe802, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData spades = IconData(0xe803, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}
