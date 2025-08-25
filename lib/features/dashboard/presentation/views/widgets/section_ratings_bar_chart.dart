import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/section_ratings_model.dart';

class SectionRatingsBarChart extends StatelessWidget {
  final List<SectionRatingStat> items;
  final List<Color> colors;

  const SectionRatingsBarChart({
    super.key,
    required this.items,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface.withOpacity(.75);

    final groups = <BarChartGroupData>[
      for (int i = 0; i < items.length; i++)
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: items[i].averageRating,
              width: 18.w,
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  colors[i].withOpacity(.9),
                  colors[i].withOpacity(.6),
                ],
              ),
              borderRadius: BorderRadius.circular(6.r),
            ),
          ],
        ),
    ];

    return BarChart(
      BarChartData(
        maxY: 5, // ratings out of 5
        minY: 0,
        alignment: BarChartAlignment.spaceAround,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (v) => FlLine(
            color: onSurface.withOpacity(.12),
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),

        // no hover tooltip boxes
        barTouchData: const BarTouchData(enabled: false),

        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 36.w,
              interval: 1,
              getTitlesWidget: (v, _) => Padding(
                padding: EdgeInsets.only(right: 6.w),
                child: Text(
                  v.toInt().toString(),
                  style: TextStyle(fontSize: 10.sp, color: onSurface),
                ),
              ),
            ),
          ),
          bottomTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          // Put value labels on the top axis aligned with each bar
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24.h,
              interval: 1,
              getTitlesWidget: (v, _) {
                final i = v.toInt();
                if (i < 0 || i >= items.length) return const SizedBox.shrink();
                final value = items[i].averageRating;
                if (value <= 0) return const SizedBox.shrink();
                return Text(
                  value.toStringAsFixed(value % 1 == 0 ? 0 : 1),
                  style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w700, color: onSurface),
                );
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
