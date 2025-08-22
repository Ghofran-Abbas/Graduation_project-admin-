import 'package:admin_alhadara_dashboard/features/ads/presentation/views/widgets/createAds_view.dart';
import 'package:admin_alhadara_dashboard/features/ads/presentation/views/widgets/updateDetail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';

import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_image_network.dart';

import '../../../../../../core/widgets/secretary/custom_empty_widget.dart';

import '../../../../../core/utils/go_router_path.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../../../core/widgets/custom_number_pagination.dart';
import '../../../data/models/ad_model.dart';
import '../../manager/getAllAdsCubit/active_cubit.dart';
import '../../manager/getAllAdsCubit/active_state.dart';

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
//                 // title + add button
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
//                         showDialog<bool>(
//                           context: context,
//                           builder: (_) => BlocProvider<CreateAdCubit>(
//                             create: (_) => getIt<CreateAdCubit>(),
//                             child: const CreateAnnouncementView(),
//                           ),
//                         ).then((created) {
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
//                 // content
//                 Expanded(
//                   child: ads.isEmpty
//                       ? CustomEmptyWidget(
//                     firstText: AppLocalizations.of(context).translate('No announcements at this time'),
//                     secondText: AppLocalizations.of(context).translate('Add new announcements to see them here.'),
//                   )
//                       : LayoutBuilder(
//                     builder: (context, constraints) {
//                       const minItemWidth = 250.0;
//                       final availableWidth = constraints.maxWidth;
//                       int crossAxisCount = (availableWidth / minItemWidth).floor();
//                       if (crossAxisCount < 1) crossAxisCount = 1;
//
//                       // Desired tile height (adjust this number to make card taller/shorter)
//                       final double desiredTileHeight = 360.w; // use w/h depending on your scale
//                       final tileWidth = availableWidth / crossAxisCount;
//                       final childAspectRatio = tileWidth / desiredTileHeight;
//
//                       return GridView.builder(
//                         padding: EdgeInsets.zero,
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: crossAxisCount,
//                           mainAxisSpacing: 24.h,
//                           crossAxisSpacing: 24.w,
//                           childAspectRatio: childAspectRatio,
//                         ),
//                         itemCount: ads.length,
//                         itemBuilder: (_, i) => _AdCard(ad: ads[i]),
//                       );
//                     },
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
//     final dateText = DateFormat('yyyy-MM-dd').format(ad.startDate);
//
//     return GestureDetector(
//       onTap: () {
//         context.go('/announcements/${ad.id}');
//       },
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16.r),
//         ),
//         elevation: 4,
//         child: Padding(
//           padding: EdgeInsets.all(12.w),
//           child: Column(
//             mainAxisSize: MainAxisSize.min, // important
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // image
//               SizedBox(
//                 width: 120.w,
//                 height: 120.h,
//                 child: ClipOval(
//                   child: CustomImageNetwork(
//                     image: ad.photo,
//                     imageWidth: 120.w,
//                     imageHeight: 120.h,
//                     borderRadius: 64.r,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10.h),
//
//               // title (2 lines max)
//               Text(
//                 ad.title,
//                 style: Styles.b1Normal(color: AppColors.t4),
//                 textAlign: TextAlign.center,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//
//               SizedBox(height: 6.h),
//
//               // description (optional, limited)
//               if (ad.description.isNotEmpty)
//                 Text(
//                   ad.description,
//                   style: Styles.b2Normal(color: AppColors.t2),
//                   textAlign: TextAlign.center,
//                   maxLines: 3,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//
//               SizedBox(height: 6.h),
//
//               Text(
//                 dateText,
//                 style: Styles.b2Normal(color: AppColors.t2),
//               ),
//
//               SizedBox(height: 10.h),
//
//               // action buttons
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.edit, size: 26.r, color: AppColors.blue),
//                     onPressed: () {
//                       showDialog<bool>(
//                         context: context,
//                         builder: (_) => BlocProvider<UpdateAdCubit>(
//                           create: (_) => getIt<UpdateAdCubit>(),
//                           child: UpdateAnnouncementView(ad: ad),
//                         ),
//                       ).then((updated) {
//                         if (updated == true) {
//                           context.read<AdsCubit>().fetchAds(page: 1);
//                         }
//                       });
//                     },
//                   ),
//                   SizedBox(width: 12.w),
//                   IconButton(
//                     icon: Icon(Icons.delete, size: 26.r, color: AppColors.red),
//                     onPressed: () async {
//                       final confirmed = await showDialog<bool>(
//                         context: context,
//                         builder: (ctx) => AlertDialog(
//                           title: Text('Are you sure?'),
//                           content: Text('Do you really want to delete this announcement?'),
//                           actions: [
//                             TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: Text('Cancel')),
//                             TextButton(onPressed: () => Navigator.of(ctx).pop(true), child: Text('Delete')),
//                           ],
//                         ),
//                       );
//
//                       if (confirmed == true) {
//                         // افترض أن لديك DeleteAdCubit مسجّلة في الشجرة أعلاه
//                         context.read<DeleteAdCubit>().deleteAd(ad.id);
//                       }
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



class AnnouncementsViewBody extends StatefulWidget {
  const AnnouncementsViewBody({Key? key}) : super(key: key);

  @override
  State<AnnouncementsViewBody> createState() => _AnnouncementsViewBodyState();
}

class _AnnouncementsViewBodyState extends State<AnnouncementsViewBody> {
  bool _showOnlyActive = false;

  bool _isAdActive(AdModel ad) {
    final now = DateTime.now().toUtc();
    final start = ad.startDate.toUtc();
    final end = ad.endDate.toUtc();
    // active if now in [start, end]
    return !now.isBefore(start) && !now.isAfter(end);
  }

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
            final allAds = state.page.ads;
            final ads = _showOnlyActive ? allAds.where(_isAdActive).toList() : allAds;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title + Active toggle + add button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // title + Active toggle
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              AppLocalizations.of(context).translate('Announcements'),
                              style: Styles.h2Bold(color: AppColors.blue),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          // Active toggle (keeps on same page)
                          GestureDetector(
                            onTap: () {
                              setState(() => _showOnlyActive = !_showOnlyActive);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color: _showOnlyActive ? Colors.white : Colors.white,
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(color: AppColors.t2.withOpacity(0.2)),
                              ),
                              child: Row(
                                children: [
                                  // green dot if active filter enabled
                                  Container(
                                    width: 10.w,
                                    height: 10.w,
                                    decoration: BoxDecoration(
                                      color: _showOnlyActive ? Colors.green : Colors.grey,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    AppLocalizations.of(context).translate('Active'),
                                    style: Styles.b2Bold(
                                      color: _showOnlyActive ? AppColors.t4 : AppColors.t3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // + New announcement button
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
                    firstText: _showOnlyActive
                        ? AppLocalizations.of(context).translate('No active announcements at this time')
                        : AppLocalizations.of(context).translate('No announcements at this time'),
                    secondText: _showOnlyActive
                        ? AppLocalizations.of(context).translate('There are no announcements currently active.')
                        : AppLocalizations.of(context).translate('Add new announcements to see them here.'),
                  )
                      : LayoutBuilder(
                    builder: (context, constraints) {
                      const minItemWidth = 250.0;
                      final availableWidth = constraints.maxWidth;
                      int crossAxisCount = (availableWidth / minItemWidth).floor();
                      if (crossAxisCount < 1) crossAxisCount = 1;

                      // calculate childAspectRatio based on desired tile height
                      final double desiredTileHeight = 360.0; // adjust to taste
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

                SizedBox(height: 16.h),

                // pagination only when showing all (if you want it hidden for active, adjust)
                if (!_showOnlyActive)
                  Center(
                    child: CustomNumberPagination(
                      numberPages: state.page.lastPage,
                      initialPage: state.page.currentPage,
                      onPageChange: (idx) => context.read<AdsCubit>().fetchAds(page: idx + 1),
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
            mainAxisSize: MainAxisSize.min,
            children: [
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
              Text(
                ad.title,
                style: Styles.b1Normal(color: AppColors.t4),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 6.h),
              if (ad.description.isNotEmpty)
                Text(
                  ad.description,
                  style: Styles.b2Normal(color: AppColors.t2),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              SizedBox(height: 6.h),
              Text(dateText, style: Styles.b2Normal(color: AppColors.t2)),
              const Spacer(),
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
                        if (updated == true) context.read<AdsCubit>().fetchAds(page: 1);
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
                        // delete via DeleteAdCubit if available in ancestor providers
                        try {
                          context.read<DeleteAdCubit>().deleteAd(ad.id);
                        } catch (_) {
                          // if no cubit provided, fallback to calling AdsCubit.fetchAds after deleting elsewhere
                        }
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