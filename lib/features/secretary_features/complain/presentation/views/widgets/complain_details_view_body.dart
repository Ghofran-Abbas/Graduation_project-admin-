import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../../../core/widgets/secretary/custom_profile_information.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../report/presentation/manager/get_file_cubit/get_file_cubit.dart';
import '../../../../report/presentation/manager/get_file_cubit/get_file_state.dart';
import '../../manager/details_complain_cubit/details_complain_cubit.dart';
import '../../manager/details_complain_cubit/details_complain_state.dart';

class ComplainDetailsViewBody extends StatelessWidget {
  const ComplainDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsComplainCubit, DetailsComplainState>(
        builder: (context, state) {
          if(state is DetailsComplainSuccess) {
            return BlocConsumer<GetFileCubit, GetFileState>(
                listener: (context, state) {
                  if (state is GetFileLoading) {
                    CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('GetFileLoading'),color: AppColors.darkLightPurple, textColor: AppColors.black);
                  } else if (state is GetFileSuccess) {
                    CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('GetFileSuccess'),);
                  }
                },
                builder: (contextGF, stateGF) {
                return Padding(
                  padding: EdgeInsets.only(top: 56.0.h,),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: CustomScreenBody(
                      title: AppLocalizations.of(context).translate('Complains')/*state.complain.data.name*/,
                      onPressedFirst: () {},
                      onPressedSecond: () {},
                      body: Padding(
                        padding: EdgeInsets.only(top: 195.0.h,
                            left: 20.0.w,
                            right: 20.0.w,
                            bottom: 27.0.h),
                        child: CustomDetailsInformation(
                          imageWidth: 176.w,
                          imageHeight: 176.w,
                          image: state.complain.data.student.photo,
                          name: state.complain.data.student.name,
                          showDetailsText: true,
                          showAboutText: true,
                          showFileTapText: true,
                          aboutText: state.complain.data.description,
                          onTap: () {
                            if(state.complain.data.filePath!.isNotEmpty) {
                              GetFileCubit.get(context).fetchFile(
                                filePath: state.complain.data.filePath!,
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                );
              }
            );
          } else if(state is DetailsComplainFailure) {
            return CustomErrorWidget(errorMessage: state.errorMessage);
          } else {
            return CustomCircularProgressIndicator();
          }
        }
    );
  }
}
