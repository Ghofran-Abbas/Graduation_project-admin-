import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/top_courses_model.dart';

class TopCoursesDonut extends StatelessWidget {
  final List<TopCourseStat> items;     // already filtered/sorted
  final List<Color> colors;            // per-item color
  const TopCoursesDonut({super.key, required this.items, required this.colors});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = items.fold<int>(0, (s, e) => s + e.totalStudents);

    if (total == 0) {
      return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.pie_chart_outline_rounded, color: Colors.black38, size: 32.sp),
            SizedBox(height: 8.h),
            Text(
              'No registrations yet',
              style: TextStyle(color: Colors.black54, fontSize: 12.sp),
            ),
          ],
        ),
      );
    }

    final sections = <PieChartSectionData>[];
    for (int i = 0; i < items.length; i++) {
      final e = items[i];
      final v = e.totalStudents.toDouble();
      if (v <= 0) continue;
      sections.add(
        PieChartSectionData(
          value: v,
          color: colors[i],
          radius: 54.r,
          title: '', // titles in legend, not on the chart
        ),
      );
    }

    return PieChart(
      PieChartData(
        sections: sections,
        centerSpaceRadius: 36.r,
        sectionsSpace: 2.w,
        startDegreeOffset: -90, // start at top
        pieTouchData: PieTouchData(enabled: false),
      ),
      swapAnimationDuration: const Duration(milliseconds: 500),
      swapAnimationCurve: Curves.easeOutCubic,
    );
  }
}
