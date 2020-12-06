import 'package:dash/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import 'daily_bar_chart.dart';
import 'drawer_button.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Box(
      width: double.infinity,
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Vertical(
            children: [
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: DrawerButton(),
              ),
              const SizedBox(height: 40),
              Text(
                'LAST 7 DAYS',
                style: textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Text(
                      '15.7',
                      style: TextStyle(
                        color: theme.accentColor,
                        fontSize: 56,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rubik',
                      ),
                    ),
                    const SizedBox(width: 16),
                    RelativeImprovement(
                      text: '10.3',
                      isPositive: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Opacity(
                opacity: 0.75,
                child: Text(
                  'KILOMETERS',
                  style: textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 216,
                child: DailyBarChart(
                  activities: createMockActivities(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<MockActivity> createMockActivities() {
    final start = now.startOfWeek.subtract(7.days);

    return [
      MockActivity(time: start.add(0.days), distance: 10.0),
      MockActivity(time: start.add(1.days), distance: 10.0),
      MockActivity(time: start.add(2.days), distance: 5.0),
      MockActivity(time: start.add(3.days), distance: 0.0),
      MockActivity(time: start.add(4.days), distance: 1.0),
      MockActivity(time: start.add(5.days), distance: 10.0),
      MockActivity(time: start.add(6.days), distance: 5.0),
      MockActivity(time: start.add(7.days), distance: 8.0),
      MockActivity(time: start.add(8.days), distance: 3.0),
      MockActivity(time: start.add(9.days), distance: 2.0),
      MockActivity(time: start.add(10.days), distance: 4.5),
      MockActivity(time: start.add(11.days), distance: 15.0),
      MockActivity(time: start.add(12.days), distance: 12.0),
      MockActivity(time: start.add(13.days), distance: 4.0),
    ];
  }
}
