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
        if(state is DetailsStudentSuccess) {
          return Padding(
            padding: EdgeInsets.only(top: 56.0.h,),
            child: CustomScreenBody(
              title: state.showResult.student.name,
              showSearchField: true,
              onPressedFirst: () {},
              onPressedSecond: () {},
              onTapSearch: () {
                context.go(GoRouterPath.searchStudent);
              },
              body: Padding(
                padding: EdgeInsets.only(
                    top: 238.0.h, left: 20.0.w, right: 20.0.w, bottom: 27.0.h),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomProfileInformation(
                        image: state.showResult.student.photo,
                        name: state.showResult.student.name,
                        firstBoxText: state.showResult.student.phone,
                        firstBoxIcon: Icons.phone_in_talk_outlined,
                        secondBoxText: state.showResult.student.email,
                        secondBoxIcon: Icons.mail_outlined,
                        firstFieldInfoText: state.showResult.student.birthday.toString().replaceRange(10, 23, ''),
                        secondFieldInfoText: state.showResult.student.gender,
                        thirdFieldInfoText: state.showResult.student.points.toString(),
                        showThirdFieldInfoIcon: true,
                        showThirdFieldInfo: true,
                        labelText: AppLocalizations.of(context).translate('Students from the same class'),
                        tailText: AppLocalizations.of(context).translate('See more'),
                        avatarCount: 1,
                        showGifts: true,
                        textGifts: 'Click to see ${state.showResult.student.name} awards',
                        onTapGifts: (){},
                        onTap: () {
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
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                    child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 65.h,
                                                left: 60.w,
                                                right: 155.w),
                                            child: Text(
                                              AppLocalizations.of(context).translate('Edit points'),
                                              style: Styles.h3Bold(
                                                  color: AppColors.t3),
                                            ),
                                          ),
                                          CustomLabelTextFormField(
                                            labelText: AppLocalizations.of(context).translate('Number'),
                                            showLabelText: true,
                                            controller: pointController,
                                            topPadding: 60.h,
                                            bottomPadding: 0.h,
                                            rightPadding: 60.w,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 90.h,
                                                bottom: 65.h,
                                                left: 47.w,
                                                right: 155.w),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              children: [
                                                TextIconButton(
                                                  textButton: AppLocalizations.of(context).translate('Add'),
                                                  bigText: true,
                                                  textColor: AppColors.t3,
                                                  icon: Icons.add,
                                                  iconSize: 40.01.r,
                                                  iconColor: AppColors.t2,
                                                  iconLast: false,
                                                  firstSpaceBetween: 3.w,
                                                  buttonHeight: 53.h,
                                                  borderWidth: 0.w,
                                                  buttonColor: AppColors.white,
                                                  borderColor: Colors
                                                      .transparent,
                                                  onPressed: () {},
                                                ),
                                                SizedBox(width: 42.w,),
                                                TextIconButton(
                                                  textButton: AppLocalizations.of(context).translate('       Discount       '),
                                                  textColor: AppColors.t3,
                                                  iconLast: false,
                                                  buttonHeight: 53.h,
                                                  borderWidth: 0.w,
                                                  borderRadius: 4.r,
                                                  buttonColor: AppColors.w1,
                                                  borderColor: AppColors.w1,
                                                  onPressed: () {
                                                    pointController.clear();
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
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 52.h, bottom: 20.h, left: 20.w, right: 20.w,),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${AppLocalizations.of(context).translate('Courses')} ${state.showResult.student.name} ${AppLocalizations.of(context).translate('learns')}',
                              style: Styles.b2Bold(color: AppColors.t4),
                            ),
                            SizedBox(height: 10.h,),
                            CustomOverLoadingCard(
                              cardCount: count,
                              onTapSeeMore: () {},
                              widget: GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    crossAxisSpacing: 10.w,
                                    mainAxisExtent: 354.66.h),
                                itemBuilder: (BuildContext context, int index) {
                                  return Align(child: CustomCard(
                                    text: 'English',
                                    showDetailsText: true,
                                    detailsText: 'Section1',
                                    secondDetailsText: 'Languages',
                                    showSecondDetailsText: true,
                                    onTap: () {
                                      /*context.go('${GoRouterPath.courses}/1${GoRouterPath.courseDetails}');*/
                                    },
                                    onTapFirstIcon: (){},
                                    onTapSecondIcon: (){},
                                  ));
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
        } else if(state is DetailsStudentFailure) {
          return CustomErrorWidget(errorMessage: state.errorMessage);
        } else {
          return CustomCircularProgressIndicator();
        }
      }
    );
  }
}
