
import 'package:admin_alhadara_dashboard/features/points/presentation/views/widgets/edit_points_dialog.dart';
import 'package:admin_alhadara_dashboard/features/points/presentation/views/widgets/list_view_information_field_for_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_snack_bar.dart';
import '../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../data/models/student_point_model.dart';
import '../manager/top_students_cubit/top_students_cubit.dart';
import '../manager/top_students_cubit/top_students_state.dart';
import '../manager/update_points_cubit/update_points_cubit.dart';
import '../manager/update_points_cubit/update_points_state.dart';
import '../views/widgets/custom_list_information_fields_for_points.dart';

class TopStudentsView extends StatelessWidget {
  const TopStudentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<UpdatePointsCubit, UpdatePointsState>(
          listener: (ctx, state) {
            if (state is UpdatePointsSuccess) {
              CustomSnackBar.showSnackBar(ctx, msg: t.translate('Points updated'));
              ctx.read<TopStudentsCubit>().fetchTopStudents(limit: 10);
            } else if (state is UpdatePointsFailure) {
              CustomSnackBar.showErrorSnackBar(ctx, msg: state.error);
            }
          },
        ),
      ],
      child: BlocBuilder<TopStudentsCubit, TopStudentsState>(
        builder: (ctx, state) {
          if (state is TopStudentsLoading) {
            return const Center(child: CustomCircularProgressIndicator());
          }
          if (state is TopStudentsFailure) {
            return CustomErrorWidget(errorMessage: state.error);
          }
          final students = (state as TopStudentsSuccess).students;

          return Padding(
            padding: EdgeInsets.only(top: 46.h),
            child: CustomScreenBody(
              title: t.translate('Top Students'),
              showSearchField: false,
              onPressedFirst: () {},
              onPressedSecond: () {},
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 58.h),
                child: students.isEmpty
                    ? Center(child: Text(t.translate('No students found')))
                    : CustomListInformationFieldsForPoints(
                  showSecondField: true,
                  widget: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: students.length,
                    itemBuilder: (_, i) {
                      final s = students[i];
                      return InformationFieldItemForPoints(
                        color: i.isOdd ? Colors.grey[200]! : Colors.white,
                        name: s.name,
                        secondText: '${s.points}',
                        onEditTap: () async {
                          final didSave = await EditPointsDialog.show(context, s);
                          if (didSave == true) {
                            ctx.read<TopStudentsCubit>().fetchTopStudents(limit: 10);
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