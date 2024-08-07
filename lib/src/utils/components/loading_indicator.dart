import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

loadingIndicator(double? media, {Color? colorScheme}) {
  return SizedBox(
    width: media ?? 0,
    height: 2,
    child: LinearProgressIndicator(color: colorScheme ?? kPrimaryColor),
  );
}
