import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/service_locator.dart';
import '../../data/repos/dashboard_repo_impl.dart';
import '../manager/section_ratings_cubit/section_ratings_cubit.dart';
import '../manager/top_courses_cubit/top_courses_cubit.dart';
import '../manager/yearly_students_cubit/yearly_students_cubit.dart';
import '../manager/monthly_students_cubit/monthly_students_cubit.dart';
import 'widgets/dashboard_view_body.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = getIt.get<DashboardRepoImpl>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TopCoursesCubit(repo)..load()),
        BlocProvider(create: (_) => YearlyStudentsCubit(repo)..load()),
        BlocProvider(create: (_) => MonthlyStudentsCubit(repo)),
        BlocProvider(create: (_) => SectionRatingsCubit(getIt.get<DashboardRepoImpl>())
          ..load( // sensible defaults, e.g. last 60 days
            start: DateTime.now().subtract(const Duration(days: 60)),
            end: DateTime.now(),
            limit: 5,
            order: 'desc',
          )
        ),
      ],
      child: const DashboardViewBody(),
    );
  }
}
