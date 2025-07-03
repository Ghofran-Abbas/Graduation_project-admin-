// lib/features/employee/presentation/views/employee_details_view.dart

import 'package:admin_alhadara_dashboard/features/employee/presentation/views/widgets/employee_details_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../points/data/repos/points_repo_impl.dart';
import '../../../points/presentation/manager/top_secretaries_cubit/top_secretaries_cubit.dart';
import '../../../points/presentation/manager/update_secretary_points_cubit/update_secretary_points_cubit.dart';
import '../../data/repos/employee_repo_impl.dart';
import '../manager/details_employee_cubit/details_employee_cubit.dart';

class EmployeeDetailsView extends StatefulWidget {
  final int id;
  const EmployeeDetailsView({Key? key, required this.id}) : super(key: key);

  @override
  _EmployeeDetailsViewState createState() => _EmployeeDetailsViewState();
}

class _EmployeeDetailsViewState extends State<EmployeeDetailsView> {
  late final DetailsEmployeeCubit _detailsCubit;
  late final UpdateSecretaryPointsCubit _updatePointsCubit;
  late int _currentId;

  @override
  void initState() {
    super.initState();
    _currentId = widget.id;
    _detailsCubit = DetailsEmployeeCubit(getIt.get<EmployeeRepoImpl>());
    _updatePointsCubit = UpdateSecretaryPointsCubit(getIt.get<PointsRepoImpl>());
    _detailsCubit.fetchEmployee(_currentId);
  }

  @override
  void didUpdateWidget(covariant EmployeeDetailsView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.id != widget.id) {
      _currentId = widget.id;
      _detailsCubit.fetchEmployee(_currentId);
    }
  }

  @override
  void dispose() {
    _detailsCubit.close();
    _updatePointsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // your existing cubits:
        BlocProvider.value(value: _detailsCubit),
        BlocProvider.value(value: _updatePointsCubit),

        // add this one so your body can read TopSecretariesCubit:
        BlocProvider(
          create: (_) => TopSecretariesCubit(getIt<PointsRepoImpl>())
          // fetch *all* secretaries so the one you're viewing is included:
            ..fetchTopSecretaries(limit: 100),
        ),
      ],
      child: const EmployeeDetailsViewBody(),
    );
  }
}
