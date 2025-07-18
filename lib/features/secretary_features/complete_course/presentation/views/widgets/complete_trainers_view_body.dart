import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_number_pagination.dart';
import '../../../../../../core/widgets/secretary/custom_empty_widget.dart';
import '../../../../../../core/widgets/secretary/custom_list_information_fields.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/custom_top_information_field.dart';
import '../../../../../../core/widgets/secretary/list_view_information_field.dart';
import '../../../../course/presentation/manager/trainers_section_cubit/trainers_section_cubit.dart';
import '../../../../course/presentation/manager/trainers_section_cubit/trainers_section_state.dart';

class CompleteTrainersViewBody extends StatelessWidget {
  const CompleteTrainersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainersSectionCubit, TrainersSectionState>(
        builder: (context, state) {
          if(state is TrainersSectionSuccess) {
            return Padding(
              padding: EdgeInsets.only(top: 56.0.h,),
              child: CustomScreenBody(
                title: state.trainers.trainers![0].name,
                onPressedFirst: () {},
                onPressedSecond: () {},
                body: Padding(
                  padding: EdgeInsets.only(top: 238.0.h,
                      left: 20.0.w,
                      right: 20.0.w,
                      bottom: 27.0.h),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        state.trainers.trainers![0].trainers!.isNotEmpty ? CustomTopInformationField(
                          firstText: '${state.trainers.trainers![0].trainers!.length} ${AppLocalizations.of(context).translate('Trainer')}',
                          firstIconColor: AppColors.purple,
                          secondText: '',
                          secondIcon: Icons.calendar_today_outlined,
                          secondIconColor: Colors.transparent,
                          thirdText: '',
                          thirdIcon: Icons.watch_later_outlined,
                          thirdIconColor: Colors.transparent,
                          isTrainer: true,
                        ) : SizedBox(width: 0.w, height: 0.h,),
                        SizedBox(height: 40.h,),
                        state.trainers.trainers![0].trainers!.isNotEmpty ? CustomListInformationFields(
                          secondField: AppLocalizations.of(context).translate('Subject'),
                          showSecondField: true,
                          widget: ListView.builder(
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
                                  context.go('${GoRouterPath.completeDetails}/${state.trainers.trainers![0].id}${GoRouterPath.completeTrainers}/${state.trainers.trainers![0].id}${GoRouterPath.detailsCompleteTrainer}/${state.trainers.trainers![0].id}/${state.trainers.trainers![0].trainers![index].id}');
                                },
                                onTapFirstIcon: () {},
                                onTapSecondIcon: () {},
                              ));
                            },
                            itemCount: state.trainers.trainers![0].trainers!.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                          )
                        ) : CustomEmptyWidget(
                          firstText: AppLocalizations.of(context).translate('No trainers in this section at this time'),
                          secondText: AppLocalizations.of(context).translate('Trainers will appear here after they add to the section.'),
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
