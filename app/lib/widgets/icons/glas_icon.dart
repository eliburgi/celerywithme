import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const _kSmallGlasSize = 38.0;
const _kLargeGlasSize = 48.0;

class EmptyGlasIcon extends StatelessWidget {
  EmptyGlasIcon._({
    @required this.size,
  });

  EmptyGlasIcon.small() : this._(size: _kSmallGlasSize);

  EmptyGlasIcon.large() : this._(size: _kLargeGlasSize);

  final double size;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    double size = screenSize.height < 600 ? this.size * 0.8 : this.size;
    return SvgPicture.asset(
      'assets/ic_empty_glas.svg',
      width: size,
      height: size,
    );
  }
}

class FilledGlasIcon extends StatelessWidget {
  FilledGlasIcon._({
    @required this.size,
  });

  FilledGlasIcon.small() : this._(size: _kSmallGlasSize);

  FilledGlasIcon.large() : this._(size: _kLargeGlasSize);

  final double size;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    double size = screenSize.height < 600 ? this.size * 0.8 : this.size;
    return SvgPicture.asset(
      'assets/ic_filled_glas.svg',
      width: size,
      height: size,
    );
  }
}
