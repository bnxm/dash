import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class DrawerButton extends StatelessWidget {
  final double size;
  final Color? color;
  const DrawerButton({
    Key? key,
    this.size = 24.0,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildBar(context, 1.0),
          buildBar(context, 0.7),
        ],
      ),
    );
  }

  Widget buildBar(BuildContext context, double fraction) {
    return FractionallySizedBox(
      widthFactor: fraction,
      alignment: AlignmentDirectional.centerStart,
      child: Box(
        height: size * 0.12,
        width: double.infinity,
        color: color ?? Theme.of(context).iconTheme.color,
        borderRadius: size * 0.05,
      ),
    );
  }
}
