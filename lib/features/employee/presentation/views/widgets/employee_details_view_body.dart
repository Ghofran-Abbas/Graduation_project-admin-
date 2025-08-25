// lib/features/employee/presentation/views/employee_details_view_body.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../core/widgets/custom_image_network.dart';
import '../../../../../core/widgets/secretary/custom_profile_information.dart';
import '../../../../../core/widgets/secretary/custom_screen_body.dart';

import '../../../../points/data/models/secretary_point_model.dart';
import '../../../../points/presentation/views/widgets/edit_secretary_points_dialog.dart';
import '../../../../points/presentation/manager/top_secretaries_cubit/top_secretaries_cubit.dart';
import '../../../../points/presentation/manager/top_secretaries_cubit/top_secretaries_state.dart';
import '../../../../points/presentation/manager/update_secretary_points_cubit/update_secretary_points_cubit.dart';

import '../../../data/models/details_employee_model.dart';

import '../../manager/details_employee_cubit/details_employee_cubit.dart';
import '../../manager/details_employee_cubit/details_employee_state.dart';

class EmployeeDetailsViewBody extends StatelessWidget {
  const EmployeeDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return BlocBuilder<DetailsEmployeeCubit, DetailsEmployeeState>(
      builder: (context, empState) {
        if (empState is DetailsEmployeeLoading) {
          return const Center(child: CustomCircularProgressIndicator());
        }
        if (empState is DetailsEmployeeFailure) {
          return CustomErrorWidget(errorMessage: empState.error);
        }
        if (empState is DetailsEmployeeSuccess) {
          final EmployeeDetail emp = empState.employee;

          // Now nest inside TopSecretariesCubit to grab that model
          return BlocBuilder<TopSecretariesCubit, TopSecretariesState>(
            builder: (context, ptsState) {
              int? points;
              if (ptsState is TopSecretariesSuccess) {
                final sp = ptsState.secretaries
                    .firstWhere((s) => s.id == emp.id, orElse: () => SecretaryPoint(id: emp.id, name: emp.name, email: emp.email, points: 0));
                points = sp.points;
              }

              return Padding(
                padding: EdgeInsets.only(top: 56.h),
                child: CustomScreenBody(
                  onPressedFirst: () {},
                  onPressedSecond: () {},
                  title: t.translate('Employee'),
                  showSearchField: false,
                  showFirstButton: false,
                  showSecondButton: false,
                  body: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 100.h,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomProfileInformation(
                            image: emp.photo,
                            labelText: '',
                            name: emp.name,
                            showDetailsText: true,
                            detailsText: emp.role,
                            firstBoxText: emp.phone,
                            firstBoxIcon: Icons.phone_outlined,
                            secondBoxText: emp.email,
                            secondBoxIcon: Icons.email_outlined,
                            firstFieldInfoText:
                            DateFormat('yyyy/MM/dd').format(emp.birthday),
                            secondFieldInfoText: emp.gender,

                            // ◀── POINTS INJECTION ──▶
                            thirdFieldInfoText:
                            (emp.role.toLowerCase() == 'secretary' && points != null)
                                ? points.toString()
                                : '',
                            showThirdFieldInfo:
                            emp.role.toLowerCase() == 'secretary',
                            showThirdFieldInfoIcon:
                            emp.role.toLowerCase() == 'secretary',
                            onTap: () async {
                              if (emp.role.toLowerCase() == 'secretary') {
                                final sp = SecretaryPoint(
                                  id: emp.id,
                                  name: emp.name,
                                  email: emp.email,
                                  points: points ?? 0,
                                  photo: emp.photo,
                                  phone: emp.phone,
                                  birthday: emp.birthday.toIso8601String(),
                                  gender: emp.gender,
                                  createdAt: emp.createdAt,
                                  updatedAt: emp.updatedAt,
                                );
                                final didSave =
                                await EditSecretaryPointsDialog.show(
                                    context, sp);
                                if (didSave == true) {
                                  // refresh both details and the points list
                                  context
                                      .read<DetailsEmployeeCubit>()
                                      .fetchEmployee(emp.id);
                                  context
                                      .read<TopSecretariesCubit>()
                                      .fetchTopSecretaries(limit: 100);
                                }
                              }
                            },

                            // ── UNCHANGED ──
                            showGifts: emp.role.toLowerCase() == 'secretary',
                            textGifts: t.translate('Click to see awards'),
                            onTapGifts: () {
                              context.go('/employees/${emp.id}/gifts');
                            },
                            tailText: '',
                            avatarCount: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
