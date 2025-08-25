import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/section_ratings_model.dart';

class SectionRatingsLegend extends StatelessWidget {
  final List<SectionRatingStat> items;
  final List<Color> colors;
  const SectionRatingsLegend({super.key, required this.items, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(items.length, (i) {
        final e = items[i];
        final c = colors[i];

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // color dot
              Container(
                width: 10.w,
                height: 10.w,
                decoration: BoxDecoration(color: c.withOpacity(.9), shape: BoxShape.circle),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  e.sectionName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(width: 8.w),
              // stars
              Row(
                children: List.generate(5, (s) {
                  final filled = e.averageRating >= s + 1;
                  final half = !filled && e.averageRating > s && e.averageRating < s + 1;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.5.w),
                    child: Icon(
                      half ? Icons.star_half_rounded : (filled ? Icons.star_rounded : Icons.star_border_rounded),
                      size: 16.sp,
                      color: c.withOpacity(.95),
                    ),
                  );
                }),
              ),
              SizedBox(width: 8.w),
              // total ratings chip
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: c.withOpacity(.08),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: c.withOpacity(.25)),
                ),
                child: Text(
                  e.totalRatings.toString(),
                  style: TextStyle(color: c.withOpacity(.95), fontWeight: FontWeight.w700, fontSize: 12.sp),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
