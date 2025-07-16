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
import '../../../../../../core/widgets/secretary/custom_over_loading_card.dart';
import '../../../../../../core/widgets/secretary/custom_profile_cards.dart';
import '../../../../../../core/widgets/secretary/custom_profile_information.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/grid_view_cards.dart';
import '../../manager/archive_trainer_cubit/archive_trainer_cubit.dart';
import '../../manager/archive_trainer_cubit/archive_trainer_state.dart';
import '../../manager/details_trainer_cubit/details_trainer_cubit.dart';
import '../../manager/details_trainer_cubit/details_trainer_state.dart';

class TrainerDetailsViewBody extends StatelessWidget {
  const TrainerDetailsViewBody({super.key, required this.trainerId});

  final int trainerId;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = ((screenWidth - 210) / 250).floor();
    crossAxisCount = crossAxisCount < 2 ? 2 : crossAxisCount;
    int count = 7;
    return BlocConsumer<DetailsTrainerCubit, DetailsTrainerState>(
      listener: (context, state) {},
      builder: (context, state) {
        if(state is DetailsTrainerSuccess) {
          return Padding(
            padding: EdgeInsets.only(top: 56.0.h,),
            child: CustomScreenBody(
              title: state.showResult.trainer.name,
              showSearchField: true,
              onPressedFirst: () {},
              onPressedSecond: () {},
              onTapSearch: () {
                context.go(GoRouterPath.searchTrainer);
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
                        image: state.showResult.trainer.photo,
                        name: state.showResult.trainer.name,
                        detailsText: state.showResult.trainer.specialization,
                        showDetailsText: true,
                        firstBoxText: state.showResult.trainer.phone,
                        firstBoxIcon: Icons.phone_in_talk_outlined,
                        secondBoxText: state.showResult.trainer.email,
                        secondBoxIcon: Icons.mail_outlined,
                        aboutText: state.showResult.trainer.experience,
                        showAboutText: true,
                        firstFieldInfoText: state.showResult.trainer.birthday,
                        secondFieldInfoText: state.showResult.trainer.gender,
                        labelText: AppLocalizations.of(context).translate('Trainers teach the same subject'),
                        tailText: AppLocalizations.of(context).translate('See more'),
                        avatarCount: 1,
                        onTap: () {},
                        onTapGifts: (){},
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 52.h, bottom: 20.h, left: 20.w, right: 20.w,),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${AppLocalizations.of(context).translate('Courses by')} ${state.showResult.trainer.name}',
                              style: Styles.b2Bold(color: AppColors.t4),
                            ),
                            SizedBox(height: 10.h,),
                            BlocBuilder<ArchiveTrainerCubit, ArchiveTrainerState>(
                                builder: (contextAr, stateAr) {
                                  if(stateAr is ArchiveTrainerSuccess) {
                                    return CustomOverLoadingCard(
                                      cardCount: count,
                                      onTapSeeMore: () {
                                        context.go('${GoRouterPath.trainerDetails}/${state.showResult.trainer.id}${GoRouterPath.trainerArchiveCourseView}/${state.showResult.trainer.id}');
                                      },
                                      widget: GridView.builder(
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: crossAxisCount,
                                            crossAxisSpacing: 10.w,
                                            mainAxisExtent: 354.66.h),
                                        itemBuilder: (BuildContext context, int index) {
                                          return Align(child: CustomCard(
                                            image: stateAr.showResult.courses.data![index].course.photo,
                                            text: stateAr.showResult.courses.data![index].course.name,
                                            showDate: true,
                                            dateText: stateAr.showResult.courses.data![index].name,
                                            //secondDetailsText: 'Languages',
                                            //showSecondDetailsText: true,
                                            onTap: () {
                                              context.go('${GoRouterPath.trainerDetails}/${state.showResult.trainer.id}${GoRouterPath.trainerArchiveCourseView}/${state.showResult.trainer.id}${GoRouterPath.archiveSectionTrainerView}/${stateAr.showResult.courses.data![index].id}/${stateAr.showResult.courses.data![index].course.id}/$trainerId');
                                            },
                                            onTapFirstIcon: (){},
                                            onTapSecondIcon: (){},
                                          ));
                                        },
                                        itemCount: stateAr.showResult.courses.data!.length > 4 ? 4 : stateAr.showResult.courses.data!.length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                      ),
                                    );
                                  } else if(stateAr is ArchiveTrainerFailure) {
                                    return CustomErrorWidget(errorMessage: stateAr.errorMessage);
                                  } else {
                                    return CustomCircularProgressIndicator();
                                  }
                                }
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
        } else if(state is DetailsTrainerFailure) {
          return CustomErrorWidget(errorMessage: state.errorMessage);
        } else {
          return CustomCircularProgressIndicator();
        }
      }
    );
  }
}
