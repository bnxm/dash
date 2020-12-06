import 'dart:math' as math;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class DailyBarChart extends ImplicitAnimation {
  final List<_ActivityPair> activities;
  DailyBarChart({
    Key? key,
    Duration duration = const Millis(1500),
    required List<MockActivity> activities,
  })   : activities = _getDailyPairs(activities),
        super(key, duration, Curves.ease);

  static List<_ActivityPair> _getDailyPairs(List<MockActivity> activities) {
    final startOfThisWeek = now.startOfWeek;
    final startOfLastWeek = now.startOfWeek.subtract(7.days);

    final thisWeekId = startOfThisWeek.weekId;
    final lastWeekId = startOfLastWeek.weekId;

    final List<MockActivity> lastWeek = [];
    final List<MockActivity> thisWeek = [];

    for (final activity in activities) {
      if (activity.time.weekId == thisWeekId) {
        thisWeek.add(activity);
      }

      if (activity.time.weekId == lastWeekId) {
        lastWeek.add(activity);
      }
    }

    return List.generate(
      7,
      (day) => _ActivityPair(
        thisWeek.mergeAtDay(startOfThisWeek.add(day.days)),
        lastWeek.mergeAtDay(startOfLastWeek.add(day.days)),
      ),
    );
  }

  @override
  _DailyBarChartState createState() => _DailyBarChartState();
}

class _DailyBarChartState
    extends ImplicitAnimationState<List<_ActivityPair>, DailyBarChart> {
  @override
  Widget builder(BuildContext context, List<_ActivityPair> pairs) {
    final chart = SizeBuilder(
      builder: (context, width, height) {
        final barWidth = (width * (1 / pairs.length)) * (3 / 4);
        final maxDistance = pairs.getMax((pair) => pair.maxDistance).maxDistance;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (final pair in pairs) buildPair(pair, barWidth, maxDistance),
          ],
        );
      },
    );

    return Column(
      children: [
        Expanded(child: chart),
        const SizedBox(height: 12),
        buildLegend(),
      ],
    );
  }

  Widget buildLegend() {
    Widget buildItem(String name, Color color) {
      return Row(
        children: [
          Box(
            radius: 3,
            color: color,
          ),
          const SizedBox(width: 8),
          Text(
            name,
            style: textTheme.caption,
          ),
        ],
      );
    }

    return Row(
      children: [
        buildItem('This week', schema.primary),
        buildItem(
          'Last week',
          theme.isLight ? Colors.grey.shade200 : Colors.grey.shade800,
        ),
      ].seperate(
        const SizedBox(width: 8),
      ),
    );
  }

  Widget buildPair(
    _ActivityPair pair,
    double barWidth,
    double maxDistance,
  ) {
    const minHeightFraction = 0.1;

    Widget buildBar(MockActivity activity, Color color) {
      final text = Align(
        alignment: Alignment(
          0.0,
          lerpDouble(
            -1.0,
            1.0 - (minHeightFraction * 2),
            1.0 - (activity.distance / maxDistance),
          ),
        ),
        child: buildTextLabel(
          activity,
          activity == pair.thisWeek ? color : schema.onSurfaceLight,
        ),
      );

      return Expanded(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                Invisible(child: buildTextLabel(pair.thisWeek, Colors.black)),
                Expanded(
                  child: FractionallySizedBox(
                    heightFactor: minHeightFraction +
                        lerpDouble(
                          0.0,
                          1.0 - minHeightFraction,
                          activity.distance / maxDistance,
                        ),
                    alignment: Alignment.bottomCenter,
                    child: Box(
                      color: color,
                      width: double.infinity,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10),
                        bottom: Radius.circular(2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            text,
          ],
        ),
      );
    }

    final time = Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        pair.thisWeek.time.E().toUpperCase(),
        maxLines: 1,
        style: textTheme.caption,
      ),
    );

    return SizedBox(
      width: barWidth,
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                buildBar(
                  pair.lastWeek,
                  theme.isLight ? Colors.grey.shade200 : Colors.grey.shade900,
                ),
                const SizedBox(width: 4),
                buildBar(
                  pair.thisWeek,
                  pair.thisWeek.time.isToday ? schema.secondary : schema.primary,
                ),
              ],
            ),
          ),
          time,
        ],
      ),
    );
  }

  Widget buildTextLabel(MockActivity activity, Color color) {
    final style = TextStyle(fontSize: 10, fontFamily: 'Rubik');

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: AutoSizeText(
        activity.distance.format('#.#'),
        style: style.copyWith(color: color),
        minFontSize: 5.0,
        textAlign: TextAlign.end,
        overflow: TextOverflow.fade,
        maxLines: 1,
      ),
    );
  }

  @override
  List<_ActivityPair> lerp(List<_ActivityPair> a, List<_ActivityPair> b, double t) {
    return a.imap((i, a) => a.scaleTo(b[i], t));
  }

  @override
  List<_ActivityPair> get newValue => widget.activities;
}

class MockActivity {
  final DateTime time;
  final double distance;
  const MockActivity({
    required this.time,
    required this.distance,
  });

  MockActivity scaleTo(MockActivity b, double t) {
    return MockActivity(
      time: t < 0.5 ? time : b.time,
      distance: lerpDouble(distance, b.distance, t),
    );
  }
}

extension _MockActivityExtensions on List<MockActivity> {
  MockActivity mergeAtDay(DateTime day) {
    final activities = filter((a) => a.time.dateId == day.dateId);
    final distance = activities.sumBy((a) => a.distance);

    return MockActivity(
      time: activities.firstOrNull?.time ?? day,
      distance: distance,
    );
  }
}

class _ActivityPair {
  final MockActivity thisWeek;
  final MockActivity lastWeek;
  const _ActivityPair(
    this.thisWeek,
    this.lastWeek,
  );

  double get maxDistance => math.max(thisWeek.distance, lastWeek.distance);
  double get totalDistance => thisWeek.distance + lastWeek.distance;

  _ActivityPair scaleTo(_ActivityPair b, double t) {
    return _ActivityPair(
      thisWeek.scaleTo(b.thisWeek, t),
      lastWeek.scaleTo(b.lastWeek, t),
    );
  }
}
