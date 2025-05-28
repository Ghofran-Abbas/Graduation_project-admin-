import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../data/repos/course_repo_impl.dart';
import '../manager/confirmed_students_section_cubit/confirmed_students_section_cubit.dart';
import '../manager/reservation_students_section_cubit/reservation_students_section_cubit.dart';
import '../manager/students_section_cubit/students_section_cubit.dart';
import 'widgets/section_students_view_body.dart';

class SectionStudentsView extends StatelessWidget {
  const SectionStudentsView({super.key, required this.sectionId});

  final int sectionId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return StudentsSectionCubit(
              getIt.get<CourseRepoImpl>(),
            )..fetchStudentsSection(id: sectionId, page: 1);
          },
        ),
        BlocProvider(
          create: (context) {
            return ConfirmedStudentsSectionCubit(
              getIt.get<CourseRepoImpl>(),
            )..fetchConfirmedStudentsSection(id: sectionId, page: 1);
          },
        ),
        BlocProvider(
          create: (context) {
            return ReservationStudentsSectionCubit(
              getIt.get<CourseRepoImpl>(),
            )..fetchReservationStudentsSection(id: sectionId, page: 1);
          },
        ),
      ],
      child: SectionStudentsViewBody(sectionId: sectionId,),
    );
  }
}
