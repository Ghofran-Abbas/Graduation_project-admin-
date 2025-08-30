import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/trainer_ratings_model.dart';

class TrainerRatingsBarChart extends StatelessWidget {
  final List<TrainerRatingStat> items;
  final List<Color> colors;
  const TrainerRatingsBarChart({super.key, required this.items, required this.colors});

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface.withOpacity(.75);

    final groups = <BarChartGroupData>[
      for (int i = 0; i < items.length; i++)
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: items[i].averageRating,
              width: 18.w,
              gradient: LinearGradient(
                begin: Alignment.bottomCenter, end: Alignment.topCenter,
                colors: [colors[i].withOpacity(.9), colors[i].withOpacity(.6)],
              ),
              borderRadius: BorderRadius.circular(6.r),
            ),
          ],
        ),
    ];

    return BarChart(
      BarChartData(
        maxY: 5, minY: 0, alignment: BarChartAlignment.spaceAround,
        gridData: FlGridData(
          show: true, drawVerticalLine: false,
          getDrawingHorizontalLine: (v) => FlLine(
            color: onSurface.withOpacity(.12), strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        barTouchData: const BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true, interval: 1, reservedSize: 36.w,
              getTitlesWidget: (v, _) => Padding(
                padding: EdgeInsets.only(right: 6.w),
                child: Text('${v.toInt()}', style: TextStyle(fontSize: 10.sp, color: onSurface)),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true, reservedSize: 52.h, interval: 1,
              getTitlesWidget: (v, _) {
                final i = v.toInt();
                if (i < 0 || i >= items.length) return const SizedBox.shrink();
                return Padding(
                  padding: EdgeInsets.only(top: 6.h),
                  child: Transform.rotate(
                    angle: -math.pi / 6,
                    child: SizedBox(
                      width: 80.w,
                      child: Text(
                        items[i].trainerName,
                        maxLines: 1, overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10.sp, color: onSurface),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true, reservedSize: 24.h, interval: 1,
              getTitlesWidget: (v, _) {
                final i = v.toInt();
                if (i < 0 || i >= items.length) return const SizedBox.shrink();
                final val = items[i].averageRating;
                if (val <= 0) return const SizedBox.shrink();
                return Text(val.toStringAsFixed(val % 1 == 0 ? 0 : 1),
                    style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w700, color: onSurface));
              },
            ),
          ),
        ),
        barGroups: groups,
      ),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
  }
}
