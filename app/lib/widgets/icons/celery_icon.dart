import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a>
class CeleryIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      // svg images are currently not supported for web
      return SizedBox.shrink();
    }

    return Transform.rotate(
      angle: -pi / 8,
      child: SvgPicture.asset(
        'assets/ic_celery.svg',
        height: 32.0,
      ),
    );
  }
}
