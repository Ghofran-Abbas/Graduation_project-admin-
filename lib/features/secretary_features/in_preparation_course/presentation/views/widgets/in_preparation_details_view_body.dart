import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/secretary/custom_check_box.dart';
import '../../../../../../core/widgets/secretary/custom_course_information.dart';
import '../../../../../../core/widgets/secretary/custom_empty_widget.dart';
import '../../../../../../core/widgets/secretary/custom_overloading_avatar.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/grid_view_files.dart';
import '../../../../../../core/widgets/text_icon_button.dart';
import '../../../../course/presentation/manager/create_section_cubit/create_section_cubit.dart';
import '../../../../course/presentation/manager/details_course_cubit/details_course_cubit.dart';
import '../../../../course/presentation/manager/details_course_cubit/details_course_state.dart';
import '../../../../course/presentation/manager/students_section_cubit/students_section_cubit.dart';
import '../../../../course/presentation/manager/students_section_cubit/students_section_state.dart';
import '../../../../course/presentation/manager/trainers_section_cubit/trainers_section_cubit.dart';
import '../../../../course/presentation/manager/trainers_section_cubit/trainers_section_state.dart';
import '../../../../course/presentation/views/widgets/course_details_view_body.dart';
import '../../../data/models/in_preparation_model.dart';
import '../../manager/in_preparation_cubit/in_preparation_cubit.dart';
import '../../manager/in_preparation_cubit/in_preparation_state.dart';

class DetailsInPreparationViewBody extends StatelessWidget {
  DetailsInPreparationViewBody({super.key, required this.courseId});

  final int courseId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailsCourseCubit, DetailsCourseState>(
        listener: (contextDC, stateDC) {},
        builder: (contextDC, stateDC)  {
          if(stateDC is DetailsCourseSuccess) {
            return BlocConsumer<InPreparationCubit, InPreparationState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is InPreparationSuccess) {
                    final List<DatumInPreparation> sections = state.createResult.data!;
                    return Padding(
                      padding: EdgeInsets.only(top: 56.0.h,),
                      child: CustomScreenBody(
                        title: stateDC.course.course.name,
                        textFirstButton: 'Section 2',
                        showFirstButton: true,
                        widget: BlocBuilder<SelectInPreparationCubit, SelectInPreparationState>(
                          builder: (context, selectState) {
                            DatumInPreparation? selected;
                            if (selectState is SelectInPreparationSuccess) {
                              selected = selectState.section;
                            }
                            return Padding(
                              padding: EdgeInsets.only(top: 0.h, bottom: 0.h),
                              child: DropdownMenu<DatumInPreparation>(
                                enableSearch: false,
                                requestFocusOnTap: false,
                                width: 200.w,
                                hintText: AppLocalizations.of(context).translate('No section'),
                                initialSelection: selected,
                                inputDecorationTheme: InputDecorationTheme(
                                  constraints: BoxConstraints(
                                      maxHeight: 53.h),
                                  hintStyle: Styles.l1Normal(
                                      color: AppColors.t0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.purple,
                                      width: 1.23,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        24.67.r),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.purple,
                                      width: 1.23,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        24.67.r),
                                  ),
                                ),
                                alignmentOffset: Offset(4, 2),
                                menuStyle: MenuStyle(
                                  backgroundColor: WidgetStateColor
                                      .resolveWith(
                                        (states) {
                                      return AppColors.white;
                                    },
                                  ),
                                  elevation: WidgetStateProperty.resolveWith(
                                        (states) {
                                      return 0;
                                    },
                                  ),
                                  side: WidgetStateBorderSide.resolveWith(
                                        (states) {
                                      return BorderSide(
                                        width: 1.23,
                                        color: AppColors.purple,

                                      );
                                    },
                                  ),

                                ),
                                dropdownMenuEntries: sections.map((section) {
                                  return DropdownMenuEntry<DatumInPreparation>(
                                    value: section,
                                    label: section.name,
                                  );
                                }).toList(),
                                onSelected: (DatumInPreparation? selectedSection) {
                                  if (selectedSection != null) {
                                    BlocProvider.of<SelectInPreparationCubit>(
                                        context).selectSection(
                                        section: selectedSection);
                                    log('✅ Selected ID: ${selectedSection
                                        .id}');
                                  }
                                },
                              ),
                            );
                          },
                        ),
                        showButtonIcon: true,
                        onPressedFirst: (){},
                        onPressedSecond: (){},
                        body: BlocConsumer<SelectInPreparationCubit, SelectInPreparationState>(
                            listener: (contextSec, stateSec) {
                              if (stateSec is SelectInPreparationSuccess) {
                                TrainersSectionCubit.get(context).fetchTrainersSection(id: stateSec.section.id, page: 1);
                                StudentsSectionCubit.get(context).fetchStudentsSection(id: stateSec.section.id, page: 1);
                              }
                            },
                            builder: (context, stateSec) {
                              if (stateSec is SelectInPreparationSuccess) {
                                return BlocConsumer<TrainersSectionCubit, TrainersSectionState>(
                                    listener: (contextTS, stateTS) {},
                                    builder: (contextTS, stateTS) {
                                      return BlocBuilder<StudentsSectionCubit, StudentsSectionState>(
                                          builder: (contextSS, stateSS) {
                                            return Padding(
                                              padding: EdgeInsets.only(top: 238.0.h, left: 77.0.w, bottom: 27.0.h),
                                              child: SingleChildScrollView(
                                                physics: BouncingScrollPhysics(),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        CustomCourseInformation(
                                                          image: stateDC.course.course.photo,
                                                          showSectionInformation: true,
                                                          ratingText: '0.0',
                                                          ratingPercent: 0,
                                                          ratingPercentText: '0%',
                                                          circleStatusColor: AppColors.mintGreen,
                                                          courseStatusText: handleReceiveState(state: stateSec.section.state),
                                                          startDateText: stateSec.section.startDate.toString().replaceRange(10, 23, ''),
                                                          showCourseCalenderIcon: true,
                                                          endDateText: stateSec.section.endDate.toString().replaceRange(10, 23, ''),
                                                          numberSeatsText: '${stateSec.section.seatsOfNumber} ${AppLocalizations.of(context).translate('Seats')}',
                                                          bodyText: stateDC.course.course.description,
                                                          onTap: (){},
                                                          onTapDate: (){
                                                            context.go('${GoRouterPath.inPreparationDetails}/$courseId${GoRouterPath.inPreparationCalendar}/${stateSec.section.id}');
                                                          },
                                                          onTapFirstIcon: (){},
                                                          onTapSecondIcon: (){},
                                                        ),
                                                        SizedBox(height: 22.h),
                                                        Row(
                                                          mainAxisSize: MainAxisSize.max,
                                                          children: [
                                                            BlocBuilder<StudentsSectionCubit, StudentsSectionState>(
                                                                builder: (contextSS, stateSS) {
                                                                  if(stateSS is StudentsSectionSuccess) {
                                                                    return Row(
                                                                      children: [
                                                                        CustomOverloadingAvatar(
                                                                          labelText: '${AppLocalizations.of(context).translate('Look at')} ${stateSS.students.students.data![0].students!.length} ${AppLocalizations.of(context).translate('students in this class')}',
                                                                          tailText: AppLocalizations.of(context).translate('See more'),
                                                                          firstImage: stateSS.students.students.data![0].students!.isNotEmpty ? stateSS.students.students.data![0].students![0].photo : '',
                                                                          secondImage: stateSS.students.students.data![0].students!.length >= 2 ? stateSS.students.students.data![0].students![1].photo : '',
                                                                          thirdImage: stateSS.students.students.data![0].students!.length >= 3 ? stateSS.students.students.data![0].students![2].photo : '',
                                                                          fourthImage: stateSS.students.students.data![0].students!.length >= 4 ? stateSS.students.students.data![0].students![3].photo : '',
                                                                          fifthImage: stateSS.students.students.data![0].students!.length >= 5 ? stateSS.students.students.data![0].students![4].photo : '',
                                                                          avatarCount: stateSS.students.students.data![0].students!.length,
                                                                          onTap: () {context.go('${GoRouterPath.inPreparationDetails}/${stateSS.students.students.data![0].id}${GoRouterPath.inPreparationStudents}/${stateSS.students.students.data![0].id}');
                                                                            //onTap: () {context.go('${GoRouterPath.courses}/${stateDC.course.course.departmentId}${GoRouterPath.courseDetails}/${stateDC.course.course.id}${GoRouterPath.sectionStudents}/${stateSec.section.id}');
                                                                          },
                                                                        ),
                                                                        SizedBox(
                                                                          width: calculateWidthBetweenAvatars(avatarCount: stateSS.students.students.data![0].students!.length) /*270.w*/,),
                                                                      ],
                                                                    );
                                                                  } else if(stateSS is StudentsSectionFailure) {
                                                                    return Row(
                                                                      children: [
                                                                        CustomOverloadingAvatar(
                                                                          labelText: '${AppLocalizations.of(context).translate('Look at')} ${AppLocalizations.of(context).translate('students in this class')}',
                                                                          tailText: AppLocalizations.of(context).translate('See more'),
                                                                          firstImage: '',
                                                                          secondImage: '',
                                                                          thirdImage: '',
                                                                          fourthImage: '',
                                                                          fifthImage: '',
                                                                          avatarCount: 5,
                                                                          onTap: () {//context.go('${GoRouterPath.inPreparationDetails}/1${GoRouterPath.inPreparationTrainers}/1');
                                                                            //onTap: () {context.go('${GoRouterPath.courses}/${stateDC.course.course.departmentId}${GoRouterPath.courseDetails}/${stateDC.course.course.id}${GoRouterPath.sectionStudents}/${stateSec.section.id}');
                                                                          },
                                                                        ),
                                                                        SizedBox(
                                                                          width: calculateWidthBetweenAvatars(avatarCount: 5) /*270.w*/,),
                                                                      ],
                                                                    );
                                                                  } else {
                                                                    return CustomCircularProgressIndicator();
                                                                  }
                                                                }
                                                            ),
                                                            BlocBuilder<TrainersSectionCubit, TrainersSectionState>(
                                                                builder: (contextTS, stateTS) {
                                                                  if(stateTS is TrainersSectionSuccess) {
                                                                    return Expanded(
                                                                      child: CustomOverloadingAvatar(
                                                                        labelText: '${AppLocalizations.of(context).translate('Look at')} ${stateTS.trainers.trainers![0].trainers!.length} ${AppLocalizations.of(context).translate('trainers in this class')}',
                                                                        tailText: AppLocalizations.of(context).translate('See more'),
                                                                        firstImage: stateTS.trainers.trainers![0].trainers!.isNotEmpty ? stateTS.trainers.trainers![0].trainers![0].photo : '',
                                                                        secondImage: stateTS.trainers.trainers![0].trainers!.length >= 2 ? stateTS.trainers.trainers![0].trainers![1].photo : '',
                                                                        thirdImage: stateTS.trainers.trainers![0].trainers!.length >= 3 ? stateTS.trainers.trainers![0].trainers![2].photo : '',
                                                                        fourthImage: stateTS.trainers.trainers![0].trainers!.length >= 4 ? stateTS.trainers.trainers![0].trainers![3].photo : '',
                                                                        fifthImage: stateTS.trainers.trainers![0].trainers!.length >= 5 ? stateTS.trainers.trainers![0].trainers![4].photo : '',
                                                                        avatarCount: stateTS.trainers.trainers![0].trainers!.length,
                                                                        onTap: () {
                                                                          context.go('${GoRouterPath.inPreparationDetails}/${stateTS.trainers.trainers![0].id}${GoRouterPath.inPreparationTrainers}/${stateTS.trainers.trainers![0].id}');
                                                                          //context.go('${GoRouterPath.courses}/${stateDC.course.course.departmentId}${GoRouterPath.courseDetails}/${stateDC.course.course.id}${GoRouterPath.sectionTrainers}/${state.section.id}');
                                                                        },
                                                                      ),
                                                                    );
                                                                  } else if(stateTS is TrainersSectionFailure) {
                                                                    return Row(
                                                                      children: [
                                                                        CustomOverloadingAvatar(
                                                                          labelText: '${AppLocalizations.of(context).translate('Look at')} ${AppLocalizations.of(context).translate('trainers in this class')}',
                                                                          tailText: AppLocalizations.of(context).translate('See more'),
                                                                          firstImage: '',
                                                                          secondImage: '',
                                                                          thirdImage: '',
                                                                          fourthImage: '',
                                                                          fifthImage: '',
                                                                          avatarCount: 5,
                                                                          onTap: () {//context.go('${GoRouterPath.inPreparationDetails}/2${GoRouterPath.inPreparationTrainers}/1');
                                                                            //onTap: () {context.go('${GoRouterPath.courses}/${stateDC.course.course.departmentId}${GoRouterPath.courseDetails}/${stateDC.course.course.id}${GoRouterPath.sectionStudents}/${stateSec.section.id}');
                                                                          },
                                                                        ),
                                                                        SizedBox(
                                                                          width: calculateWidthBetweenAvatars(avatarCount: 5) /*270.w*/,),
                                                                      ],
                                                                    );
                                                                  } else {
                                                                    return CustomCircularProgressIndicator();
                                                                  }
                                                                }
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(top: 40.h, right: 47.0.w,),
                                                          child: DefaultTabController(
                                                            length: 2,
                                                            child: Column(
                                                              children: [
                                                                SizedBox(
                                                                  height: 70.h,
                                                                  child: TabBar(
                                                                    labelColor: AppColors.blue,
                                                                    unselectedLabelColor: AppColors.blue,
                                                                    indicator: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: AppColors.darkBlue,
                                                                    ),
                                                                    indicatorPadding: EdgeInsets.only(top: 48.r, bottom: 12.r),
                                                                    indicatorWeight: 20,
                                                                    labelStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                                                                    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                                                                    tabs: [
                                                                      Tab(text: AppLocalizations.of(context).translate('         File         '),),
                                                                      //Tab(text: AppLocalizations.of(context).translate('Announcement')),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 570.23.h,
                                                                  child: TabBarView(
                                                                    children: [
                                                                      Column(
                                                                        mainAxisSize: MainAxisSize.max,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          //Image(image: AssetImage(Assets.empty)),
                                                                          CustomEmptyWidget(
                                                                            firstText: AppLocalizations.of(context).translate('No files in this section at this time'),
                                                                            secondText: AppLocalizations.of(context).translate('Files will appear here after they add to the section.'),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        mainAxisSize: MainAxisSize.max,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          //Image(image: AssetImage(Assets.empty)),
                                                                          Expanded(
                                                                            child: Text(
                                                                              AppLocalizations.of(context).translate('No courses at this time'),
                                                                              style: Styles.h3Bold(color: AppColors.t3),
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child: Text(
                                                                              AppLocalizations.of(context).translate('Courses will appear here after they enroll in your school.'),
                                                                              style: Styles.l1Normal(color: AppColors.t3),
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                      );
                                    }
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: 238.0.h,
                                      left: 77.0.w,
                                      bottom: 27.0.h),
                                  child: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Column(
                                          children: [
                                            CustomCourseInformation(
                                              image: stateDC.course.course.photo,
                                              bodyText: stateDC.course.course.description,
                                              onTap: () {},
                                              onTapDate: () {},
                                              onTapFirstIcon: (){},
                                              onTapSecondIcon: (){},
                                            ),
                                            //SizedBox(height: 22.h),
                                            Padding(
                                              padding: EdgeInsets.only(right: 87.w),
                                              child: CustomEmptyWidget(
                                                firstText: AppLocalizations.of(context).translate('No more at this time'),
                                                secondText: AppLocalizations.of(context).translate('Add a section to see more options.'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            }
                        ),
                      ),
                    );
                  } else if (state is InPreparationFailure) {
                    return CustomErrorWidget(
                        errorMessage: state.errorMessage);
                  } else {
                    return CustomCircularProgressIndicator();
                  }
                }
            );
          } else if(stateDC is DetailsCourseFailure) {
            return CustomErrorWidget(
                errorMessage: stateDC.errorMessage);
          } else {
            return CustomCircularProgressIndicator();
          }
        }
    );
  }
}

String handleReceiveState({required String state}) {
  if(state == 'pending') {
    return 'Pending';
  } else if(state == 'in_progress') {
    return 'In progress';
  } else if(state == 'finished') {
    return 'Finished';
  } else {
    return '';
  }
}