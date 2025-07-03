// lib/features/points/presentation/views/widgets/student_details_view_body.dart

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
import '../../../../../../core/widgets/secretary/custom_label_text_form_field.dart';
import '../../../../../../core/widgets/secretary/custom_over_loading_card.dart';
import '../../../../../../core/widgets/secretary/custom_profile_cards.dart';
import '../../../../../../core/widgets/secretary/custom_profile_information.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/grid_view_cards.dart';
import '../../../../../../core/widgets/text_icon_button.dart';

import '../../manager/details_student_cubit/details_student_cubit.dart';
import '../../manager/details_student_cubit/details_student_state.dart';
import '../../../../../points/data/models/student_point_model.dart';
import '../../../../../points/presentation/views/widgets/edit_points_dialog.dart';

class StudentDetailsViewBody extends StatelessWidget {
  StudentDetailsViewBody({super.key});

  final TextEditingController pointController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = ((screenWidth - 210) / 250).floor();
    crossAxisCount = crossAxisCount < 2 ? 2 : crossAxisCount;
    int count = 50;

    return BlocConsumer<DetailsStudentCubit, DetailsStudentState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is DetailsStudentSuccess) {
          final student = state.showResult.student;

          return Padding(
            padding: EdgeInsets.only(top: 56.0.h),
            child: CustomScreenBody(
              title: student.name,
              showSearchField: true,
              onPressedFirst: () {},
              onPressedSecond: () {},
              onTapSearch: () {
                context.go(GoRouterPath.searchStudent);
              },
              body: Padding(
                padding: EdgeInsets.only(
                  top: 238.0.h,
                  left: 20.0.w,
                  right: 20.0.w,
                  bottom: 27.0.h,
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomProfileInformation(
                        image: student.photo,
                        name: student.name,
                        firstBoxText: student.phone,
                        firstBoxIcon: Icons.phone_in_talk_outlined,
                        secondBoxText: student.email,
                        secondBoxIcon: Icons.mail_outlined,
                        firstFieldInfoText: student.birthday
                            .toString()
                            .replaceRange(10, 23, ''),
                        secondFieldInfoText: student.gender,
                        thirdFieldInfoText: student.points.toString(),
                        showThirdFieldInfoIcon: true,
                        showThirdFieldInfo: true,
                        labelText: AppLocalizations.of(
                          context,
                        ).translate('Students from the same class'),
                        tailText: AppLocalizations.of(
                          context,
                        ).translate('See more'),
                        avatarCount: 1,
                        showGifts: true,
                        textGifts:
                        'Click to see ${student.name} awards',
                        onTapGifts: () {
                          final sid = student.id;
                          context.go('/students/studentDetails/$sid/gifts');
                        },
                        onTap: () async {
                          // Use the shared EditPointsDialog:
                          final sp = StudentPoint(
                            id: student.id,
                            name: student.name,
                            points: student.points, email: student.email,
                          );
                          final didSave = await EditPointsDialog.show(context, sp);
                          if (didSave == true) {
                            // reload details after update
                            context
                                .read<DetailsStudentCubit>()
                                .fetchDetailsStudent(id: student.id);
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 52.h,
                          bottom: 20.h,
                          left: 20.w,
                          right: 20.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${AppLocalizations.of(context).translate('Courses')} ${student.name} ${AppLocalizations.of(context).translate('learns')}',
                              style: Styles.b2Bold(color: AppColors.t4),
                            ),
                            SizedBox(height: 10.h),
                            CustomOverLoadingCard(
                              cardCount: count,
                              onTapSeeMore: () {
                                context.go(
                                  '${GoRouterPath.studentDetails}/${student.id}${GoRouterPath.studentArchiveCourseView}/${student.id}',
                                );
                              },
                              widget: GridView.builder(
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  crossAxisSpacing: 10.w,
                                  mainAxisExtent: 354.66.h,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return Align(
                                    child: CustomCard(
                                      text: 'English',
                                      showDetailsText: true,
                                      detailsText: 'Section1',
                                      secondDetailsText: 'Languages',
                                      showSecondDetailsText: true,
                                      onTap: () {
                                        context.go(
                                          '${GoRouterPath.studentDetails}/${student.id}${GoRouterPath.studentArchiveCourseView}/${student.id}${GoRouterPath.archiveSectionStudentView}/1',
                                        );
                                      },
                                      onTapFirstIcon: () {},
                                      onTapSecondIcon: () {},
                                    ),
                                  );
                                },
                                itemCount: count > 4 ? 4 : count,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is DetailsStudentFailure) {
          return CustomErrorWidget(errorMessage: state.errorMessage);
        } else {
          return CustomCircularProgressIndicator();
        }
      },
    );
  }
}
