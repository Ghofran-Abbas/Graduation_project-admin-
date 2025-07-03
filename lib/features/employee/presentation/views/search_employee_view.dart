// lib/features/employee/presentation/pages/search_employee_view.dart

import 'package:admin_alhadara_dashboard/features/employee/presentation/views/widgets/search_employee_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/service_locator.dart';
import '../../data/repos/employee_repo_impl.dart';
import '../manager/search_employee_cubit/search_employee_cubit.dart';

class SearchEmployeeView extends StatelessWidget {
  const SearchEmployeeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchEmployeeCubit(getIt.get<EmployeeRepoImpl>()),
      child:SingleChildScrollView(child:SearchEmployeeViewBody(),),
    );
  }
}
