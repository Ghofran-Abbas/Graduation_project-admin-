import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/service_locator.dart';
import '../../data/repos/task_repo_impl.dart';
import '../manager/create_task_cubit/create_task_cubit.dart';
import '../manager/delete_task_cubit/delete_task_cubit.dart';
import '../manager/tasks_cubit/tasks_cubit.dart';
import '../manager/update_task_cubit/update_task_cubit.dart';
import 'widgets/tasks_view_body.dart';

class TasksView extends StatelessWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = getIt.get<TaskRepoImpl>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TasksCubit(repo)..fetchFirstPage()),
        BlocProvider(create: (_) => CreateTaskCubit(repo)),
        BlocProvider(create: (_) => UpdateTaskCubit(repo)),
        BlocProvider(create: (_) => DeleteTaskCubit(repo)),
      ],
      child: const TasksViewBody(),
    );
  }
}
