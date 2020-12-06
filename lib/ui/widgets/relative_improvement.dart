import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import 'package:dash/core/core.dart';
import 'package:dash/ui/ui.dart';

class RelativeImprovement extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final bool isPositive;
  final bool isPositiveUp;
  const RelativeImprovement({
    Key? key,
    required this.text,
    required this.isPositive,
    this.style,
    this.isPositiveUp = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final schema = DashSchema.of(context);
    final color = isPositive ? schema.positiveChange : schema.negativeChange;
    final style = this.style ?? Theme.of(context).textTheme.bodyText1;
    final iconSize = (style?.fontSize ?? 0.0) * 0.75;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RotatedBox(
          quarterTurns: (isPositiveUp ? 0 : 2) + (isPositive ? 0 : 2),
          child: SvgPicture.asset(
            R.icons.roundedArrowUp,
            height: iconSize,
            width: iconSize,
            color: color,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: style?.copyWith(
            color: color,
            fontFamily: 'Rubik',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
