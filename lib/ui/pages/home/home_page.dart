import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import 'widgets/widgets.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SystemOverlayStyleScope(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Header(),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
