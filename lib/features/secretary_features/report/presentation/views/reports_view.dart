import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../data/repos/report_repo_impl.dart';
import '../manager/create_report_cubit/create_report_cubit.dart';
import '../manager/delete_report_cubit/delete_report_cubit.dart';
import '../manager/reports_cubit/reports_cubit.dart';
import '../manager/update_report_cubit/update_report_cubit.dart';
import 'widgets/reports_view_body.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return ReportsCubit(
              getIt.get<ReportRepoImpl>(),
            )..fetchReports(page: 1);
          },
        ),
        BlocProvider(
          create: (context) {
            return DeleteReportCubit(
              getIt.get<ReportRepoImpl>(),
            );
          },
        ),
      ],
      child: const ReportsViewBody(),
    );
  }
}
