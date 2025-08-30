import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/trainer_ratings_model.dart';

class TrainerRatingsLegend extends StatelessWidget {
  final List<TrainerRatingStat> items;
  final List<Color> colors;
  const TrainerRatingsLegend({super.key, required this.items, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(items.length, (i) {
        final e = items[i];
        final c = colors[i];

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: Row(
            children: [
              Container(width: 10.w, height: 10.w,
                  decoration: BoxDecoration(color: c.withOpacity(.9), shape: BoxShape.circle)),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  e.trainerName,
                  maxLines: 1, overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(width: 8.w),
              Row(
                children: List.generate(5, (s) {
                  final filled = e.averageRating >= s + 1;
                  final half = !filled && e.averageRating > s && e.averageRating < s + 1;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.5.w),
                    child: Icon(
                      half ? Icons.star_half_rounded :
                      (filled ? Icons.star_rounded : Icons.star_border_rounded),
                      size: 16.sp, color: c.withOpacity(.95),
                    ),
                  );
                }),
              ),
              SizedBox(width: 8.w),
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
