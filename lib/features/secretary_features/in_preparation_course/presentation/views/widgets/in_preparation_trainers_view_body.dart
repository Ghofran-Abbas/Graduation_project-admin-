import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_number_pagination.dart';
import '../../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../../../core/widgets/secretary/custom_list_information_fields.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/custom_top_information_field.dart';
import '../../../../../../core/widgets/secretary/list_view_information_field.dart';
import '../../../../../../core/widgets/text_icon_button.dart';
import '../../../../course/presentation/manager/delete_section_trainer_cubit/delete_section_trainer_cubit.dart';
import '../../../../course/presentation/manager/delete_section_trainer_cubit/delete_section_trainer_state.dart';
import '../../../../course/presentation/manager/trainers_section_cubit/trainers_section_cubit.dart';
import '../../../../course/presentation/manager/trainers_section_cubit/trainers_section_state.dart';

class InPreparationTrainersViewBody extends StatelessWidget {
  const InPreparationTrainersViewBody({super.key, required this.sectionId});

  final int sectionId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainersSectionCubit, TrainersSectionState>(
        builder: (context, state) {
          if(state is TrainersSectionSuccess) {
            return Padding(
              padding: EdgeInsets.only(top: 56.0.h,),
              child: CustomScreenBody(
                title: state.trainers.trainers![0].name,
                textSecondButton: AppLocalizations.of(context).translate('Add trainer'),
                onPressedFirst: () {},
                onPressedSecond: () {
                  context.go('${GoRouterPath.inPreparationDetails}/${state.trainers.trainers![0].id}${GoRouterPath.inPreparationTrainers}/${state.trainers.trainers![0].id}${GoRouterPath.searchTrainerIp}/${state.trainers.trainers![0].id}');
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
                        CustomTopInformationField(
                          firstText: '${state.trainers.trainers![0].trainers!.length} ${AppLocalizations.of(context).translate('Trainer')}',
                          firstIconColor: AppColors.purple,
                          secondText: '',
                          secondIcon: Icons.calendar_today_outlined,
                          secondIconColor: Colors.transparent,
                          thirdText: '',
                          thirdIcon: Icons.watch_later_outlined,
                          thirdIconColor: Colors.transparent,
                          isTrainer: true,
                        ),
                        SizedBox(height: 40.h,),
                        CustomListInformationFields(
                          secondField: AppLocalizations.of(context).translate('Subject'),
                          showSecondField: true,
                          widget: state.trainers.trainers![0].trainers!.isNotEmpty ? ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return Align(child: InformationFieldItem(
                                color: index % 2 != 0 ? AppColors
                                    .darkHighlightPurple : AppColors.white,
                                image: state.trainers.trainers![0].trainers![index].photo,
                                name: state.trainers.trainers![0].trainers![index].name,
                                secondText: state.trainers.trainers![0].trainers![index].specialization,
                                showSecondDetailsText: true,
                                thirdDetailsText: state.trainers.trainers![0].trainers![index].email,
                                fourthDetailsText: state.trainers.trainers![0].trainers![index].gender,
                                onTap: () {
                                  context.go('${GoRouterPath.trainerDetails}/${state.trainers.trainers![0].trainers![index].id}');
                                },
                                onTapFirstIcon: () {},
                                onTapSecondIcon: () {},
                              ));
                            },
                            itemCount: state.trainers.trainers![0].trainers!.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                          )  : Center(heightFactor: 20.h,child: CustomErrorWidget(errorMessage: AppLocalizations.of(context).translate('No thing to display'))),
                        ),
                        CustomNumberPagination(
                          numberPages: 1/*state.trainers.trainers![0].lastPage*/,
                          initialPage: 1/*state.showResult.departments.currentPage*/,
                          onPageChange: (int index) {
                            context.read<TrainersSectionCubit>().fetchTrainersSection(id: state.trainers.trainers![0].id, page: index + 1);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if(state is TrainersSectionFailure) {
            return CustomErrorWidget(
                errorMessage: state.errorMessage);
          } else {
            return CustomCircularProgressIndicator();
          }
        }
    );
  }
}
