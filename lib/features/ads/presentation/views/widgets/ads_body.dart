import 'package:admin_alhadara_dashboard/features/ads/presentation/views/widgets/createAds_view.dart';
import 'package:admin_alhadara_dashboard/features/ads/presentation/views/widgets/updateDetail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_image_network.dart';
import '../../../../../../core/widgets/custom_number_pagination.dart';
import '../../../../../../core/widgets/secretary/custom_empty_widget.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';


import '../../../../../core/utils/service_locator.dart';
import '../../../data/models/ad_model.dart';
import '../../manager/getAllAdsCubit/add-delete_cubit.dart';
import '../../manager/getAllAdsCubit/addAdd_cubit.dart';
import '../../manager/getAllAdsCubit/getAllAdsCubit.dart';
import '../../manager/getAllAdsCubit/getAllAdsState.dart';
import '../../manager/getAllAdsCubit/updateAd_cubit.dart';
//
// class AnnouncementsViewBody extends StatelessWidget {
//   const AnnouncementsViewBody({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
//       child: BlocBuilder<AdsCubit, AdsState>(
//         builder: (context, state) {
//           if (state is AdsLoading) {
//             return const Center(child: CustomCircularProgressIndicator());
//           }
//           if (state is AdsError) {
//             return Center(child: CustomErrorWidget(errorMessage: state.message));
//           }
//           if (state is AdsLoaded) {
//             final ads = state.page.ads;
//
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         AppLocalizations.of(context).translate('Announcements'),
//                         style: Styles.h2Bold(color: AppColors.blue),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     ElevatedButton.icon(
//                       onPressed: () {
//
//                         showDialog<bool>(
//                           context: context,
//                           builder: (_) => BlocProvider<CreateAdCubit>(
//                             create: (_) => getIt<CreateAdCubit>(),
//                             child: const CreateAnnouncementView(),
//                           ),
//                         ).then((created) {
//
//                           if (created == true) {
//                             context.read<AdsCubit>().fetchAds(page: 1);
//                           }
//                         });
//                       },
//                       icon: Icon(Icons.add, size: 20.r),
//                       label: Text(
//                         AppLocalizations.of(context).translate('New announcement'),
//                         style: Styles.b2Bold(color: Colors.white),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.purple,
//                         padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(24.r),
//                         ),
//                         elevation: 4,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16.h),
//
//                 Expanded(
//                   child: ads.isEmpty
//                       ? CustomEmptyWidget(
//                     firstText: AppLocalizations.of(context)
//                         .translate('No announcements at this time'),
//                     secondText: AppLocalizations.of(context).translate(
//                         'Add new announcements to see them here.'),
//                   )
//                       : LayoutBuilder(
//                     builder: (context, constraints) {
//                       const minItemWidth = 250.0;
//                       final availableWidth = constraints.maxWidth;
//                       int crossAxisCount =
//                       (availableWidth / minItemWidth).floor();
//                       if (crossAxisCount < 1) crossAxisCount = 1;
//
//                       return GridView.builder(
//                         padding: EdgeInsets.zero,
//                         gridDelegate:
//                         SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: crossAxisCount,
//                           mainAxisSpacing: 24.h,
//                           crossAxisSpacing: 24.w,
//                           childAspectRatio: 0.9,
//                         ),
//                         itemCount: ads.length,
//                         itemBuilder: (_, i) => _AdCard(ad: ads[i]),
//                       );
//                     },
//                   ),
//                 ),
//
//                 // ---------- الترقيم ----------
//                 SizedBox(height: 16.h),
//                 Center(
//                   child: CustomNumberPagination(
//                     numberPages: state.page.lastPage,
//                     initialPage: state.page.currentPage,
//                     onPageChange: (idx) =>
//                         context.read<AdsCubit>().fetchAds(page: idx + 1),
//                   ),
//                 ),
//               ],
//             );
//           }
//
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
// }
//
// class _AdCard extends StatelessWidget {
//   final AdModel ad;
//   const _AdCard({required this.ad});
//
//   @override
//   Widget build(BuildContext context) {
//     final dateText = DateFormat('yyyy‑MM‑dd').format(ad.startDate!);
//
//     return GestureDetector(
//
//       onTap: () {
//         print('id=${ad.id}');
//         context.go('/announcements/${ad.id}');
//         print('id=${ad.id}');
//         },
//
//
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16.r),
//         ),
//         elevation: 4,
//         child: Padding(
//           padding: EdgeInsets.all(12.w),
//           child: Column(
//             children: [
//               CustomImageNetwork(
//                 image: ad.photo,
//                 imageWidth: 120.w,
//                 imageHeight: 150.h,
//                 borderRadius: 64.r,
//               ),
//               SizedBox(height: 10.h),
//               Text(
//                 ad.title,
//                 style: Styles.b1Normal(color: AppColors.t4),
//                 textAlign: TextAlign.center,
//               ),
//               Text(dateText, style: Styles.b2Normal(color: AppColors.t2)),
//               const Spacer(),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.edit, size: 30.r, color: AppColors.blue),
//                     onPressed: () {
//                       showDialog<bool>(
//                         context: context,
//                         builder: (_) => BlocProvider<UpdateAdCubit>(
//                           create: (_) => getIt<UpdateAdCubit>(),
//                           child: UpdateAnnouncementView(
//                             ad: ad,
//                           ),
//                         ),
//                       ).then((updated) {
//                         if (updated == true) {
//
//                           context.read<AdsCubit>().fetchAds(page: 1);
//                         }
//                       });
//                     },
//                   ),
//
//                   IconButton(
//                     icon: Icon(Icons.delete, size: 30.r, color: AppColors.red),
//                     onPressed: () {
//
//                       // context.read<AdsCubit>().deleteAd(ad.id);
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//









class AnnouncementsViewBody extends StatelessWidget {
  const AnnouncementsViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: BlocBuilder<AdsCubit, AdsState>(
        builder: (context, state) {
          if (state is AdsLoading) {
            return const Center(child: CustomCircularProgressIndicator());
          }
          if (state is AdsError) {
            return Center(child: CustomErrorWidget(errorMessage: state.message));
          }
          if (state is AdsLoaded) {
            final ads = state.page.ads;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title + add button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context).translate('Announcements'),
                        style: Styles.h2Bold(color: AppColors.blue),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        showDialog<bool>(
                          context: context,
                          builder: (_) => BlocProvider<CreateAdCubit>(
                            create: (_) => getIt<CreateAdCubit>(),
                            child: const CreateAnnouncementView(),
                          ),
                        ).then((created) {
                          if (created == true) {
                            context.read<AdsCubit>().fetchAds(page: 1);
                          }
                        });
                      },
                      icon: Icon(Icons.add, size: 20.r),
                      label: Text(
                        AppLocalizations.of(context).translate('New announcement'),
                        style: Styles.b2Bold(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.purple,
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        elevation: 4,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // content
                Expanded(
                  child: ads.isEmpty
                      ? CustomEmptyWidget(
                    firstText: AppLocalizations.of(context).translate('No announcements at this time'),
                    secondText: AppLocalizations.of(context).translate('Add new announcements to see them here.'),
                  )
                      : LayoutBuilder(
                    builder: (context, constraints) {
                      const minItemWidth = 250.0;
                      final availableWidth = constraints.maxWidth;
                      int crossAxisCount = (availableWidth / minItemWidth).floor();
                      if (crossAxisCount < 1) crossAxisCount = 1;

                      // Desired tile height (adjust this number to make card taller/shorter)
                      final double desiredTileHeight = 360.w; // use w/h depending on your scale
                      final tileWidth = availableWidth / crossAxisCount;
                      final childAspectRatio = tileWidth / desiredTileHeight;

                      return GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 24.h,
                          crossAxisSpacing: 24.w,
                          childAspectRatio: childAspectRatio,
                        ),
                        itemCount: ads.length,
                        itemBuilder: (_, i) => _AdCard(ad: ads[i]),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _AdCard extends StatelessWidget {
  final AdModel ad;
  const _AdCard({required this.ad});

  @override
  Widget build(BuildContext context) {
    final dateText = DateFormat('yyyy-MM-dd').format(ad.startDate);

    return GestureDetector(
      onTap: () {
        context.go('/announcements/${ad.id}');
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            mainAxisSize: MainAxisSize.min, // important
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // image
              SizedBox(
                width: 120.w,
                height: 120.h,
                child: ClipOval(
                  child: CustomImageNetwork(
                    image: ad.photo,
                    imageWidth: 120.w,
                    imageHeight: 120.h,
                    borderRadius: 64.r,
                  ),
                ),
              ),
              SizedBox(height: 10.h),

              // title (2 lines max)
              Text(
                ad.title,
                style: Styles.b1Normal(color: AppColors.t4),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: 6.h),

              // description (optional, limited)
              if (ad.description.isNotEmpty)
                Text(
                  ad.description,
                  style: Styles.b2Normal(color: AppColors.t2),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),

              SizedBox(height: 6.h),

              Text(
                dateText,
                style: Styles.b2Normal(color: AppColors.t2),
              ),

              SizedBox(height: 10.h),

              // action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, size: 26.r, color: AppColors.blue),
                    onPressed: () {
                      showDialog<bool>(
                        context: context,
                        builder: (_) => BlocProvider<UpdateAdCubit>(
                          create: (_) => getIt<UpdateAdCubit>(),
                          child: UpdateAnnouncementView(ad: ad),
                        ),
                      ).then((updated) {
                        if (updated == true) {
                          context.read<AdsCubit>().fetchAds(page: 1);
                        }
                      });
                    },
                  ),
                  SizedBox(width: 12.w),
                  IconButton(
                    icon: Icon(Icons.delete, size: 26.r, color: AppColors.red),
                    onPressed: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Are you sure?'),
                          content: Text('Do you really want to delete this announcement?'),
                          actions: [
                            TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: Text('Cancel')),
                            TextButton(onPressed: () => Navigator.of(ctx).pop(true), child: Text('Delete')),
                          ],
                        ),
                      );

                      if (confirmed == true) {
                        // افترض أن لديك DeleteAdCubit مسجّلة في الشجرة أعلاه
                        context.read<DeleteAdCubit>().deleteAd(ad.id);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



