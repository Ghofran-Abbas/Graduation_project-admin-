// lib/features/employee/presentation/views/employees_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/service_locator.dart';
import '../../data/repos/employee_repo_impl.dart';
import '../manager/create_employee_cubit/create_employee_cubit.dart';
import '../manager/delete_employee_cubit/delete_employee_cubit.dart';
import '../manager/employees_cubit/employees_cubit.dart';
import '../manager/register_secretary_cubit/register_secretary_cubit.dart';
import '../manager/update_employee_cubit/update_employee_cubit.dart';
import 'widgets/employees_view_body.dart';

class EmployeesView extends StatelessWidget {
  const EmployeesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Use fetchFirstPage to initialize pagination
        BlocProvider(
          create: (_) => EmployeesCubit(getIt.get<EmployeeRepoImpl>())
            ..fetchFirstPage(),
        ),
        BlocProvider(
          create: (_) => CreateEmployeeCubit(getIt.get<EmployeeRepoImpl>()),
        ),
        BlocProvider(
          create: (_) => UpdateEmployeeCubit(getIt.get<EmployeeRepoImpl>()),
        ),
        BlocProvider(
          create: (_) => DeleteEmployeeCubit(getIt.get<EmployeeRepoImpl>()),
        ),
        BlocProvider(
          create: (_) => RegisterSecretaryCubit(getIt.get<EmployeeRepoImpl>()),
        ),
      ],
      child: const EmployeesViewBody(),
    );
  }
}
