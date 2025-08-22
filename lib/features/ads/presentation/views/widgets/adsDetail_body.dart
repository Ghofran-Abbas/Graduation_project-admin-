// lib/features/ads/presentation/views/widgets/announcement_details_body.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../core/widgets/custom_image_network.dart';
import '../../manager/getAllAdsCubit/singleAdCubit.dart';
import '../../manager/getAllAdsCubit/singleAdState.dart';



class AnnouncementDetailsBody extends StatelessWidget {
  const AnnouncementDetailsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleAdCubit, SingleAdState>(
      builder: (context, state) {
        if (state is SingleAdLoading) {
          return const Center(child: CustomCircularProgressIndicator());
        }
        if (state is SingleAdError) {
          return Center(child: CustomErrorWidget(errorMessage: state.message));
        }
        if (state is SingleAdLoaded) {
          final ad = state.ad;
          final fmt = DateFormat('yyyy‑MM‑dd');
          final start = ad.startDate;
          final end   = ad.endDate ?? start;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Row(
              children: [

                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      SizedBox(height: 40.h),
                      CustomImageNetwork(
                        image: ad.photo,
                        imageWidth: 200.w,
                        imageHeight: 200.h,
                        borderRadius: 100.r,
                      ),
                      SizedBox(height: 24.h),
                      Text(ad.title, style: Styles.h2Bold(color: AppColors.t4)),
                      SizedBox(height: 12.h),
                      _DateRow(icon: Icons.rocket_launch_outlined, date: start),
                      SizedBox(height: 8.h),
                      _DateRow(icon: Icons.rocket_launch_outlined, date: end),
                    ],
                  ),
                ),

                SizedBox(width: 32.w),


                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 80.h),
                      Text(ad.title, style: Styles.h3Bold(color: AppColors.t4)),
                      SizedBox(height: 16.h),
                      Text(
                        AppLocalizations.of(context).translate('About'),
                        style: Styles.l2Bold(color: AppColors.t4),
                      ),
                      SizedBox(height: 8.h),
                      Text(ad.description, style: Styles.l1Normal(color: AppColors.t2)),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _DateRow extends StatelessWidget {
  final IconData icon;
  final DateTime date;
  const _DateRow({required this.icon, required this.date});

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('yyyy‑MM‑dd');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: AppColors.purple, size: 24.r),
        SizedBox(width: 8.w),
        Text(fmt.format(date), style: Styles.b2Normal(color: AppColors.t2)),
      ],
    );
  }
}



