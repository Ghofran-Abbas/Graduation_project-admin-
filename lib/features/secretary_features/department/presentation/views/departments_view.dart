import 'package:admin_alhadara_dashboard/core/utils/service_locator.dart';
import 'package:admin_alhadara_dashboard/features/secretary_features/department/data/repos/department_repo_impl.dart';
import 'package:admin_alhadara_dashboard/features/secretary_features/department/presentation/manager/create_department_cubit/create_department_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/delete_department_cubit/delete_department_cubit.dart';
import '../manager/update_department_cubit/update_department_cubit.dart';
import 'widgets/departments_view_body.dart';

class DepartmentsView extends StatelessWidget {
  const DepartmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return CreateDepartmentCubit(
              getIt.get<DepartmentRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return UpdateDepartmentCubit(
              getIt.get<DepartmentRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return DeleteDepartmentCubit(
              getIt.get<DepartmentRepoImpl>(),
            );
          },
        ),
      ],
      child: DepartmentsViewBody(),
    );
  }
}
