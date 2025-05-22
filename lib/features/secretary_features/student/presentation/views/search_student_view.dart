import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../data/repos/student_repo_impl.dart';
import '../manager/search_student_cubit/search_student_cubit.dart';
import 'widgets/search_student_view_body.dart';

class SearchStudentView extends StatelessWidget {
  const SearchStudentView({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SearchStudentCubit(
          getIt.get<StudentRepoImpl>(),
        );
      },
      child: SearchStudentViewBody(),
    );
  }
}
