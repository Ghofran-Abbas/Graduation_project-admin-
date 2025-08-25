import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/top_courses_model.dart';

class TopCoursesRankedList extends StatelessWidget {
  final List<TopCourseStat> items; // filtered/sorted to match chart
  final List<Color> colors;
  const TopCoursesRankedList({super.key, required this.items, required this.colors});

  @override
  Widget build(BuildContext context) {
    final total = items.fold<int>(0, (s, e) => s + e.totalStudents);
    return Column(
      children: List.generate(items.length, (i) {
        final e = items[i];
        final color = colors[i];
        final pct = total == 0 ? 0.0 : (e.totalStudents / total);
        final pctText = total == 0 ? '0%' : '${(pct * 100).toStringAsFixed(0)}%';

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: Column(
            children: [
              Row(
                children: [
                  // rank chip
                  Container(
                    width: 26.w,
                    height: 26.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: color.withOpacity(.12),
                      borderRadius: BorderRadius.circular(13.r),
                      border: Border.all(color: color.withOpacity(.35)),
                    ),
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12.sp,
                        color: color.withOpacity(.95),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      e.courseName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  // count chip
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: color.withOpacity(.08),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: color.withOpacity(.2)),
                    ),
                    child: Text(
                      e.totalStudents.toString(),
                      style: TextStyle(
                        color: color.withOpacity(.95),
                        fontWeight: FontWeight.w700,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    pctText,
                    style: TextStyle(color: Colors.black54, fontSize: 12.sp, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              // progress (share)
              LayoutBuilder(builder: (ctx, cons) {
                final w = cons.maxWidth;
                return Stack(
                  children: [
                    Container(
                      height: 8.h,
                      width: w,
                      decoration: BoxDecoration(
                        color: color.withOpacity(.10),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                    Container(
                      height: 8.h,
                      width: w * pct,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [color.withOpacity(.9), color.withOpacity(.6)],
                        ),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        );
      }),
    );
  }
}
