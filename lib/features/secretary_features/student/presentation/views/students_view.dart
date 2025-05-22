import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../data/repos/student_repo_impl.dart';
import '../manager/create_student_cubit/create_student_cubit.dart';
import '../manager/delete_student_cubit/delete_student_cubit.dart';
import '../manager/update_student_cubit/update_student_cubit.dart';
import 'widgets/students_view_body.dart';

class StudentsView extends StatelessWidget {
  const StudentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return CreateStudentCubit(
              getIt.get<StudentRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return UpdateStudentCubit(
              getIt.get<StudentRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return DeleteStudentCubit(
              getIt.get<StudentRepoImpl>(),
            );
          },
        ),
      ],
      child: StudentsViewBody(),
    );
  }
}
