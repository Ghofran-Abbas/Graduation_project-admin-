import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../data/repos/course_repo_impl.dart';
import '../manager/details_section_cubit/details_section_cubit.dart';
import 'widgets/calendar_view_body.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key, required this.sectionId});

  final int sectionId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return DetailsSectionCubit(
              getIt.get<CourseRepoImpl>(),
            )..fetchDetailsSection(id: sectionId);
          },
        ),
      ],
      child: CalendarViewBody(),
    );
  }
}
