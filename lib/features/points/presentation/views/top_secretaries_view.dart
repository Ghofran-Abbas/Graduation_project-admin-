


import 'package:admin_alhadara_dashboard/features/points/presentation/views/widgets/custom_list_information_fields_for_points.dart';
import 'package:admin_alhadara_dashboard/features/points/presentation/views/widgets/list_view_information_field_for_points.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_snack_bar.dart';
import '../../../../core/widgets/secretary/custom_screen_body.dart';
import '../manager/top_secretaries_cubit/top_secretaries_cubit.dart';
import '../manager/top_secretaries_cubit/top_secretaries_state.dart';
import '../manager/update_secretary_points_cubit/update_secretary_points_cubit.dart';
import '../manager/update_secretary_points_cubit/update_secretary_points_state.dart';
import 'widgets/edit_secretary_points_dialog.dart';

class TopSecretariesView extends StatelessWidget {
  const TopSecretariesView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UpdateSecretaryPointsCubit, UpdateSecretaryPointsState>(
          listener: (ctx, state) {
            if (state is UpdateSecretaryPointsSuccess) {
              CustomSnackBar.showSnackBar(ctx, msg: 'Secretary points updated');
              ctx.read().fetchTopSecretaries(limit: 10);
            } else if (state is UpdateSecretaryPointsFailure) {
              CustomSnackBar.showErrorSnackBar(ctx, msg: state.error);
            }
          },
        ),
      ],
      child: BlocBuilder<TopSecretariesCubit, TopSecretariesState>(
        builder: (ctx, state) {
          if (state is TopSecretariesLoading) {
            return const Center(child: CustomCircularProgressIndicator());
          }
          if (state is TopSecretariesFailure) {
            return CustomErrorWidget(errorMessage: state.error);
          }
          final secretaries = (state as TopSecretariesSuccess).secretaries;
          return Padding(
            padding: EdgeInsets.only(top: 46.h),
            child: CustomScreenBody(
              title: 'Top Secretaries',
              showSearchField: false,
              onPressedFirst: () {},
              onPressedSecond: () {},
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 58.h),
                child: secretaries.isEmpty
                    ? Center(child: Text('No secretaries found'))
                    : CustomListInformationFieldsForPoints(
                  showSecondField: true,
                  widget: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: secretaries.length,
                    itemBuilder: (_, i) {
                      final s = secretaries[i];
                      return InformationFieldItemForPoints(
                        color: i.isOdd ? Colors.grey[200]! : Colors.white,
                        name: s.name,
                        secondText: '${s.points}',
                        onEditTap: () async {
                          final didSave = await EditSecretaryPointsDialog.show(
                              context, s);
                          if (didSave == true) {
                            ctx.read<TopSecretariesCubit>().fetchTopSecretaries(
                                limit: 10);
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}