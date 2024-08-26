import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../content/loading_screen_content.dart';

class LoadingScreenCupertinoScaffold extends StatelessWidget {
  final void Function()? loadData;
  const LoadingScreenCupertinoScaffold({super.key, this.loadData});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;

    Future.delayed(Duration.zero, loadData ?? () {});

    return CupertinoPageScaffold(
      child: SafeArea(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            loadingScreenContent(media, colorScheme),
          ],
        ),
      ),
    );
  }
}
