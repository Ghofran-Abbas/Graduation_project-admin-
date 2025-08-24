import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/students_stats_model.dart';

class MonthlyStudentsBarChart extends StatelessWidget {
  final List<MonthlyStudentStat> items; // length 12 (zero-filled)
  const MonthlyStudentsBarChart({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final onSurface = theme.colorScheme.onSurface.withOpacity(.75);

    final maxValue = items
        .map((e) => e.totalStudents)
        .fold<int>(0, (a, b) => a > b ? a : b)
        .toDouble();

    final groups = <BarChartGroupData>[
      for (int i = 0; i < items.length; i++)
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: items[i].totalStudents.toDouble(),
              width: 16.w,
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [primary.withOpacity(.90), primary.withOpacity(.60)],
              ),
              borderRadius: BorderRadius.circular(6.r),
            ),
          ],
        ),
    ];

    return BarChart(
      BarChartData(
        maxY: (maxValue == 0 ? 1 : maxValue) * 1.2,
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

        // ⬇️ Remove hover tooltips
        barTouchData: const BarTouchData(enabled: false),

        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 36.w,
              interval: maxValue <= 10 ? 1 : null,
              getTitlesWidget: (v, _) => Padding(
                padding: EdgeInsets.only(right: 6.w),
                child: Text(
                  v % 1 == 0 ? v.toInt().toString() : v.toStringAsFixed(1),
                  style: TextStyle(fontSize: 10.sp, color: onSurface),
                ),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28.h,
              getTitlesWidget: (v, _) {
                final i = v.toInt();
                if (i < 0 || i >= items.length) return const SizedBox.shrink();
                // 1..12 numeric labels (works across locales)
                return Text('${items[i].month}',
                    style: TextStyle(fontSize: 10.sp, color: onSurface));
              },
            ),
          ),

          // ⬇️ Show each bar's value as a small label along the top axis
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24.h,
              interval: 1,
              getTitlesWidget: (v, _) {
                final i = v.toInt();
                if (i < 0 || i >= items.length) return const SizedBox.shrink();
                final value = items[i].totalStudents;
                if (value <= 0) return const SizedBox.shrink();
                return Text(
                  '$value',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: onSurface,
                  ),
                );
              },
            ),
          ),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        barGroups: groups,
      ),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
  }
}
