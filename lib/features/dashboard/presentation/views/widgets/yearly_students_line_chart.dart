import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/students_stats_model.dart';

class YearlyStudentsLineChart extends StatelessWidget {
  final List<YearlyStudentStat> items;
  const YearlyStudentsLineChart({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final onSurface = theme.colorScheme.onSurface.withOpacity(.75);

    if (items.isEmpty) return const SizedBox.shrink();

    final maxValue = items
        .map((e) => e.totalStudents)
        .fold<int>(0, (a, b) => a > b ? a : b)
        .toDouble();

    final spots = <FlSpot>[
      for (int i = 0; i < items.length; i++)
        FlSpot(i.toDouble(), items[i].totalStudents.toDouble()),
    ];

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: (items.length - 1).toDouble(),
        minY: 0,
        maxY: (maxValue == 0 ? 1 : maxValue) * 1.2,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (v) => FlLine(
            color: onSurface.withOpacity(.12),
            strokeWidth: 1,
          ),
        ),
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
              reservedSize: 26.h,
              getTitlesWidget: (v, _) {
                final i = v.toInt();
                if (i < 0 || i >= items.length) return const SizedBox.shrink();
                return Text('${items[i].year}',
                    style: TextStyle(fontSize: 10.sp, color: onSurface));
              },
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),

        // ⬇️ No hover tooltip squares anymore
        lineTouchData: const LineTouchData(enabled: false),

        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            barWidth: 3,
            gradient: LinearGradient(
              colors: [primary.withOpacity(.85), primary.withOpacity(.65)],
            ),
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [primary.withOpacity(.25), primary.withOpacity(.02)],
              ),
            ),
          ),
        ],
      ),
      duration: const Duration(milliseconds: 550),
      curve: Curves.easeOutCubic,
    );
  }
}
