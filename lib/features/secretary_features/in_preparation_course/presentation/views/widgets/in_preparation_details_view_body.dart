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
import '../../../../../../core/widgets/secretary/custom_overloading_avatar.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/grid_view_files.dart';
import '../../../../../../core/widgets/text_icon_button.dart';
import '../../../../course/presentation/manager/create_section_cubit/create_section_cubit.dart';
import '../../../../course/presentation/manager/students_section_cubit/students_section_cubit.dart';
import '../../../../course/presentation/manager/students_section_cubit/students_section_state.dart';
import '../../../../course/presentation/manager/trainers_section_cubit/trainers_section_cubit.dart';
import '../../../../course/presentation/manager/trainers_section_cubit/trainers_section_state.dart';
import '../../../../course/presentation/views/widgets/course_details_view_body.dart';

class DetailsInPreparationViewBody extends StatelessWidget {
  DetailsInPreparationViewBody({super.key});

  final List<String> statusOptions = ['In preparation', 'Active now', 'Complete',];

  @override
  Widget build(BuildContext context) {
    TrainersSectionCubit.get(context).fetchTrainersSection(id: 1/*state.section.id*/, page: 1);//****************************
    return Padding(
      padding: EdgeInsets.only(top: 56.0.h,),
      child: CustomScreenBody(
        title: 'Video Editing',
        textFirstButton: 'Section 2',
        showFirstButton: true,
        onPressedFirst: (){},
        onPressedSecond: (){},
        body: Padding(
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
                      showSectionInformation: true,
                      ratingText: '0.0',
                      ratingPercent: 0,
                      ratingPercentText: '0%',
                      circleStatusColor: AppColors.mintGreen,
                      courseStatusText: 'In preparation',
                      startDateText: '2025-09-02',
                      showCourseCalenderIcon: true,
                      endDateText: '2025-12-02',
                      numberSeatsText: '40 Seats',
                      bodyText: 'Nulla Lorem mollit cupidatat irure. Laborum\n'
                          'magna nulla duis ullamco cillum dolor.\n'
                          'Voluptate exercitation incididunt aliquip\n'
                          'deserunt reprehenderit elit laborum. Nulla\n'
                          'Lorem mollit cupidatat irure. Laborum\n'
                          'magna nulla duis ullamco cillum dolor.\n'
                          'Voluptate exercitation incididunt aliquip\n'
                          'deserunt reprehenderit elit laborum. ',
                      onTap: (){},
                      onTapDate: (){
                        context.go('${GoRouterPath.inPreparationDetails}/1${GoRouterPath.inPreparationCalendar}/1');
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
                                      onTap: () {
                                        context.go('${GoRouterPath.courses}/1${GoRouterPath.courseDetails}/1${GoRouterPath.sectionStudents}/${stateSS.students.students.data![0].id}');
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
                                      onTap: () {

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
                                return CustomOverloadingAvatar(
                                  labelText: '${AppLocalizations.of(context).translate('Look at')} ${stateTS.trainers.trainers![0].trainers!.length} ${AppLocalizations.of(context).translate('trainers in this class')}',
                                  tailText: AppLocalizations.of(context).translate('See more'),
                                  firstImage: stateTS.trainers.trainers![0].trainers!.isNotEmpty ? stateTS.trainers.trainers![0].trainers![0].photo : '',
                                  secondImage: stateTS.trainers.trainers![0].trainers!.length >= 2 ? stateTS.trainers.trainers![0].trainers![1].photo : '',
                                  thirdImage: stateTS.trainers.trainers![0].trainers!.length >= 3 ? stateTS.trainers.trainers![0].trainers![2].photo : '',
                                  fourthImage: stateTS.trainers.trainers![0].trainers!.length >= 4 ? stateTS.trainers.trainers![0].trainers![3].photo : '',
                                  fifthImage: stateTS.trainers.trainers![0].trainers!.length >= 5 ? stateTS.trainers.trainers![0].trainers![4].photo : '',
                                  avatarCount: stateTS.trainers.trainers![0].trainers!.length,
                                  onTap: () {
                                    context.go('${GoRouterPath.courses}/1${GoRouterPath.courseDetails}/1${GoRouterPath.sectionTrainers}/${stateTS.trainers.trainers![0].id}');
                                    //context.go('${GoRouterPath.courses}/${stateDC.course.course.departmentId}${GoRouterPath.courseDetails}/${stateDC.course.course.id}${GoRouterPath.sectionTrainers}/${state.section.id}');
                                  },
                                ) : Text(
                                  AppLocalizations.of(context).translate('No trainers at this time'),
                                  style: Styles.l2Bold(color: AppColors.t4),
                                );
                              } else if(stateTS is TrainersSectionFailure) {
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
                                      onTap: () {
                                        //context.go('${GoRouterPath.courses}/1${GoRouterPath.courseDetails}/2${GoRouterPath.sectionTrainers}/1');
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
                                  Tab(text: AppLocalizations.of(context).translate('Announcement')),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 470.23.h,
                              child: TabBarView(
                                children: [
                                  Column(
                                    children: [
                                      GridViewFiles(
                                        fileName: 'hgjhv',
                                        cardCount: 5,
                                      ),
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
        ),
      ),
    );
  }
}
