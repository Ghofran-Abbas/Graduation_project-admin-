import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../course/data/repos/course_repo_impl.dart';
import '../../../course/presentation/manager/trainers_section_cubit/trainers_section_cubit.dart';
import 'widgets/complete_details_view_body.dart';

class CompleteDetailsView extends StatelessWidget {
  const CompleteDetailsView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return TrainersSectionCubit(
              getIt.get<CourseRepoImpl>(),
            );
          },
        ),
      ],
      child: CompleteDetailsViewBody(),
    );
  }
}
