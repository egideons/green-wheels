import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../constants/consts.dart';

rideLocations({String? pickup, String? destination}) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          pickup ?? "",
          softWrap: true,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: defaultTextStyle(
            color: kBlackColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        kBigSizedBox,
        Text(
          destination ?? "",
          softWrap: true,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: defaultTextStyle(
            color: kDarkBlackColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}
