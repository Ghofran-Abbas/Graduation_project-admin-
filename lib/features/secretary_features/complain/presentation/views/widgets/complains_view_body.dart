import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_number_pagination.dart';
import '../../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../../../core/widgets/secretary/custom_empty_widget.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/list_view_information_field.dart';
import '../../../../../../core/widgets/text_icon_button.dart';
import '../../manager/complains_cubit/complains_cubit.dart';
import '../../manager/complains_cubit/complains_state.dart';
import '../../manager/delete_complain_cubit/delete_complain_cubit.dart';
import '../../manager/delete_complain_cubit/delete_complain_state.dart';

class ComplainsViewBody extends StatelessWidget {
  const ComplainsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteComplainCubit, DeleteComplainState>(
      listener: (context, state) {
        if (state is DeleteComplainFailure) {
          CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('DeleteComplainFailure'),);
        } else if (state is DeleteComplainSuccess) {
          CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('DeleteComplainSuccess'),);
        }
      },
      builder: (context, state) {
        return BlocBuilder<ComplainsCubit, ComplainsState>(
            builder: (context, state) {
              if(state is ComplainsSuccess) {
                return Padding(
                  padding: EdgeInsets.only(top: 56.0.h,),
                  child: CustomScreenBody(
                    title: AppLocalizations.of(context).translate('Complains'),
                    showSearchField: true,
                    onPressedFirst: () {},
                    onPressedSecond: () {},
                    onTapSearch: () {
                      context.go('${GoRouterPath.complains}${GoRouterPath.searchComplain}');
                    },
                    body: Padding(
                      padding: EdgeInsets.only(top: 238.0.h,
                          left: 20.0.w,
                          right: 20.0.w,
                          bottom: 27.0.h),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            state.complains.data.data!.isNotEmpty ? ListView.builder(
                              itemBuilder: (BuildContext context, int index) {
                                return Align(child: InformationFieldItem(
                                  color: index % 2 != 0 ? AppColors.darkHighlightPurple : AppColors.white,
                                  //image: state.complains.data.data![index].secretary.photo,
                                  name: ''/*state.reports.reports.data![index].secretary.name*/,
                                  secondText: state.complains.data.data![index].description,
                                  showSecondDetailsText: true,
                                  fifthText: handleDate(state.complains.data.data![index].createdAt),
                                  showFifthDetailsText: true,
                                  isReportStyle: true,
                                  showIcons: true,
                                  hideFirstIcon: true,
                                  isComplainStyle: true,
                                  onTap: () {
                                    context.go('${GoRouterPath.complains}${GoRouterPath.complainDetails}/${state.complains.data.data![index].id}');
                                  },
                                  onTapFirstIcon: () {},
                                  onTapSecondIcon: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext dialogContext) {
                                        return Align(
                                          alignment: Alignment.topRight,
                                          child: Material(
                                            color: Colors.transparent,
                                            child: Container(
                                              width: 638.w,
                                              height: 478.h,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 280.w, vertical: 255.h),
                                              padding: EdgeInsets.all(22.r),
                                              decoration: BoxDecoration(
                                                color: AppColors.white,
                                                borderRadius: BorderRadius.circular(
                                                    6.r),
                                              ),
                                              child: SingleChildScrollView(
                                                physics: BouncingScrollPhysics(),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(top: 65
                                                          .h, left: 30.w, right: 155
                                                          .w),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.error_outline,
                                                            color: AppColors.orange,
                                                            size: 55.r,
                                                          ),
                                                          SizedBox(width: 10.w,),
                                                          Text(
                                                            AppLocalizations.of(context).translate('Warning'),
                                                            style: Styles.h3Bold(color: AppColors.t3),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(top: 75
                                                          .h, left: 65.w, right: 155
                                                          .w),
                                                      child: Text(
                                                        AppLocalizations.of(context).translate('Are you sure you want to delete this complain?'),
                                                        style: Styles.b2Normal(
                                                            color: AppColors.t3),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(top: 90
                                                          .h, bottom: 65.h, left: 47
                                                          .w, right: 155.w),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .start,
                                                        children: [
                                                          TextIconButton(
                                                            textButton: AppLocalizations
                                                                .of(context)
                                                                .translate('Confirm'),
                                                            bigText: true,
                                                            textColor: AppColors.t3,
                                                            icon: Icons
                                                                .check_circle_outline,
                                                            iconSize: 40.01.r,
                                                            iconColor: AppColors.t2,
                                                            iconLast: false,
                                                            firstSpaceBetween: 3.w,
                                                            buttonHeight: 53.h,
                                                            borderWidth: 0.w,
                                                            buttonColor: AppColors
                                                                .white,
                                                            borderColor: Colors
                                                                .transparent,
                                                            onPressed: () {
                                                              context.read<DeleteComplainCubit>().fetchDeleteComplain(id: state.complains.data.data![index].id);
                                                              Navigator.pop(
                                                                  dialogContext);
                                                            },
                                                          ),
                                                          SizedBox(width: 42.w,),
                                                          TextIconButton(
                                                            textButton: AppLocalizations
                                                                .of(context)
                                                                .translate(
                                                                '       Cancel       '),
                                                            textColor: AppColors.t3,
                                                            iconLast: false,
                                                            buttonHeight: 53.h,
                                                            borderWidth: 0.w,
                                                            borderRadius: 4.r,
                                                            buttonColor: AppColors.w1,
                                                            borderColor: AppColors.w1,
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  dialogContext);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ));
                              },
                              itemCount: state.complains.data.data!.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                            ) : CustomEmptyWidget(
                              firstText: AppLocalizations.of(context).translate('No complains at this time'),
                              secondText: AppLocalizations.of(context).translate('Complains will appear here after they enroll in your institute.'),
                            ),
                            CustomNumberPagination(
                              numberPages: state.complains.data.lastPage,
                              initialPage: state.complains.data.currentPage,
                              onPageChange: (int index) {
                                context.read<ComplainsCubit>().fetchComplains(page: index + 1);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else if(state is ComplainsFailure) {
                return CustomErrorWidget(errorMessage: state.errorMessage);
              } else {
                return CustomCircularProgressIndicator();
              }
            }
        );
      }
    );
  }
}

String handleDate(DateTime date) {

  if(DateTime(date.year, date.month, date.day).isBefore(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).add(Duration(days: -1)))) {

    return '${date.year}-${date.month}-${date.day}';

  } else if(DateTime(date.year, date.month, date.day).isAtSameMomentAs(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).add(Duration(days: -1)))) {

    return 'Yesterday';

  } else if(DateTime(date.year, date.month, date.day, date.add(Duration(hours: 3)).hour, date.minute).isAtSameMomentAs(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute))) {

    return 'Now';

  } else if(DateTime(date.year, date.month, date.day).isAtSameMomentAs(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))) {

    return '${date.add(Duration(hours: 3)).hour}:${date.minute}';

  } else {

    return 'No Time';

  }
}