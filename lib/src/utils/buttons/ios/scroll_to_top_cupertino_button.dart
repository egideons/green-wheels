import 'package:flutter/cupertino.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../theme/colors.dart';

scrollToTopCupertinoButton(
  controller,
) {
  return CupertinoButton(
    padding: const EdgeInsets.all(0),
    borderRadius: BorderRadius.circular(100),
    onPressed: controller.scrollToTop,
    color: kPrimaryColor,
    child: const Icon(Iconsax.arrow_up_2),
  );
}
