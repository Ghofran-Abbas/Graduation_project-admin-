import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../data/repos/student_repo_impl.dart';
import '../manager/details_student_cubit/details_student_cubit.dart';
import 'widgets/student_details_view_body.dart';

class StudentDetailsView extends StatelessWidget {
  const StudentDetailsView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return DetailsStudentCubit(
          getIt.get<StudentRepoImpl>(),
        )..fetchDetailsStudent(id: id);
      },
      child: StudentDetailsViewBody(),
    );
  }
}
