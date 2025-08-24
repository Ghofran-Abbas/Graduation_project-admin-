import 'package:admin_alhadara_dashboard/features/tasks/presentation/views/widgets/task_details_dialog.dart';
import 'package:admin_alhadara_dashboard/features/tasks/presentation/views/widgets/tasks_header_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../../core/widgets/secretary/custom_screen_body.dart';

import '../../../data/models/task_model.dart';
import '../../manager/create_task_cubit/create_task_cubit.dart';
import '../../manager/create_task_cubit/create_task_state.dart';
import '../../manager/delete_task_cubit/delete_task_cubit.dart';
import '../../manager/delete_task_cubit/delete_task_state.dart';
import '../../manager/tasks_cubit/tasks_cubit.dart';
import '../../manager/tasks_cubit/tasks_state.dart';
import '../../manager/update_task_cubit/update_task_cubit.dart';
import '../../manager/update_task_cubit/update_task_state.dart';
import 'create_task_dialog.dart';
import 'task_row.dart';
import 'update_task_dialog.dart';

class TasksViewBody extends StatefulWidget {
  const TasksViewBody({super.key});

  @override
  State<TasksViewBody> createState() => _TasksViewBodyState();
}

class _TasksViewBodyState extends State<TasksViewBody> {
  late final ScrollController _scroll;

  @override
  void initState() {
    super.initState();
    _scroll = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    final cubit = context.read<TasksCubit>();
    if (!_scroll.hasClients) return;
    final maxScroll = _scroll.position.maxScrollExtent;
    final current = _scroll.position.pixels;
    if (current >= maxScroll - 200) {
      cubit.fetchNextPage();
    }
  }

  Future<void> _showCreate() async {
    final added = await showDialog<bool>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<CreateTaskCubit>(),
        child: const CreateTaskDialog(),
      ),
    );
    if (added == true) context.read<TasksCubit>().fetchFirstPage();
  }

  Future<void> _showEdit(Task task) async {
    final updated = await showDialog<bool>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<UpdateTaskCubit>(),
        child: UpdateTaskDialog(task: task),
      ),
    );
    if (updated == true) context.read<TasksCubit>().fetchFirstPage();
  }

  Future<void> _confirmDelete(int id) async {
    final loc = AppLocalizations.of(context)!;
    final should = await showDialog<bool>(
      context: context,
      builder: (d) => AlertDialog(
        title: Text(loc.translate('Delete task')),
        content: Text(loc.translate('Are you sure you want to delete this task?')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d, false), child: Text(loc.translate('Cancel'))),
          ElevatedButton(onPressed: () => Navigator.pop(d, true), child: Text(loc.translate('Confirm'))),
        ],
      ),
    );
    if (should == true) context.read<DeleteTaskCubit>().delete(id);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return MultiBlocListener(
      listeners: [
        BlocListener<CreateTaskCubit, CreateTaskState>(
          listener: (_, state) {
            if (state is CreateTaskSuccess) {
              CustomSnackBar.showSnackBar(context, msg: loc.translate('Task created successfully'));
            } else if (state is CreateTaskFailure) {
              CustomSnackBar.showErrorSnackBar(context, msg: state.error);
            }
          },
        ),
        BlocListener<UpdateTaskCubit, UpdateTaskState>(
          listener: (_, state) {
            if (state is UpdateTaskSuccess) {
              CustomSnackBar.showSnackBar(context, msg: loc.translate('Task updated successfully'));
            } else if (state is UpdateTaskFailure) {
              CustomSnackBar.showErrorSnackBar(context, msg: state.error);
            }
          },
        ),
        BlocListener<DeleteTaskCubit, DeleteTaskState>(
          listener: (_, state) {
            if (state is DeleteTaskSuccess) {
              CustomSnackBar.showSnackBar(context, msg: loc.translate('Task deleted'));
              context.read<TasksCubit>().fetchFirstPage();
            } else if (state is DeleteTaskFailure) {
              CustomSnackBar.showErrorSnackBar(context, msg: state.error);
            }
          },
        ),
      ],
      child: Padding(
        padding: EdgeInsets.only(top: 56.h),
        child:
        CustomScreenBody(onPressedSecond: (){},
          title: loc.translate('Tasks'),
          showSearchField: false,
          showFirstButton: true,
          textFirstButton: loc.translate('New Task'),
          onPressedFirst: _showCreate,
          body: Padding(
            padding: EdgeInsets.only(top: 190.h, left: 20.w, right: 20.w, bottom: 27.h),
            child: BlocBuilder<TasksCubit, TasksState>(
              builder: (context, state) {
                if (state is TasksLoading) {
                  return const Center(child: CustomCircularProgressIndicator());
                }
                if (state is TasksFailure) {
                  return CustomErrorWidget(errorMessage: state.error);
                }

                final success = state as TasksSuccess;
                final list = success.tasks;
                final totalCount = list.length + (success.hasMore ? 2 : 1);

                if (list.isEmpty) {
                  return Column(
                    children: [
                      const TasksHeaderRow(),
                      SizedBox(height: 10.h),
                      Expanded(
                        child: Center(
                          child: Text(
                            loc.translate('No tasks yet'),
                            style: TextStyle(color: Colors.black54, fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return ListView.builder(
                  controller: _scroll,
                  itemCount: totalCount,
                  itemBuilder: (context, index) {
                    if (index == 0) return const TasksHeaderRow();

                    final itemIndex = index - 1;
                    if (itemIndex < list.length) {
                      final t = list[itemIndex];
                      final assignee = t.secretary?.name ?? 'ID ${t.secretaryId}';
                      final date =
                          '${t.createdAt.year}-${t.createdAt.month.toString().padLeft(2, '0')}-${t.createdAt.day.toString().padLeft(2, '0')}';

                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.h),
                        child: TaskRow(
                          title: t.title,
                          status: t.status,
                          assignee: assignee,
                          createdAt: date,
                          onEdit: () => _showEdit(t),
                          onDelete: () => _confirmDelete(t.id),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => TaskDetailsDialog(
                                title: t.title,
                                description: t.description,
                                secretaryName: assignee,
                                status: t.status,
                                createdAt: date,
                              ),
                            );
                          },
                        ),
                      );
                    }

                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
