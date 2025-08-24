import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../core/widgets/custom_snack_bar.dart';
import '../../../data/models/task_model.dart';
import '../../manager/update_task_cubit/update_task_cubit.dart';
import '../../manager/update_task_cubit/update_task_state.dart';

class UpdateTaskDialog extends StatefulWidget {
  final Task task;
  const UpdateTaskDialog({super.key, required this.task});

  @override
  State<UpdateTaskDialog> createState() => _UpdateTaskDialogState();
}

class _UpdateTaskDialogState extends State<UpdateTaskDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  late final TextEditingController _desc;
  String _status = 'pending';

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.task.title);
    _desc = TextEditingController(text: widget.task.description);
    _status = widget.task.status;
  }

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(loc.translate('Update Task')),
      content: BlocConsumer<UpdateTaskCubit, UpdateTaskState>(
        listener: (context, state) {
          if (state is UpdateTaskFailure) {
            CustomSnackBar.showErrorSnackBar(context, msg: state.error);
          }
          if (state is UpdateTaskSuccess) {
            Navigator.pop(context, true);
          }
        },
        builder: (context, state) {
          final loading = state is UpdateTaskLoading;
          return SizedBox(
            width: 440.w,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _title,
                    decoration: InputDecoration(labelText: loc.translate('Title')),
                    validator: (v) =>
                    (v == null || v.trim().isEmpty) ? loc.translate('Required') : null,
                  ),
                  TextFormField(
                    controller: _desc,
                    decoration: InputDecoration(labelText: loc.translate('Description')),
                    maxLines: 3,
                  ),
                  DropdownButtonFormField<String>(
                    value: _status,
                    items: [
                      DropdownMenuItem(value: 'pending',     child: Text(loc.translate('Pending'))),
                      DropdownMenuItem(value: 'in_progress', child: Text(loc.translate('In progress'))),
                      DropdownMenuItem(value: 'completed',   child: Text(loc.translate('Completed'))),
                    ],
                    onChanged: (v) => setState(() => _status = v ?? 'pending'),
                    decoration: InputDecoration(labelText: loc.translate('Status')),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: loading ? null : () => Navigator.pop(context, false),
                        child: Text(loc.translate('Cancel')),
                      ),
                      SizedBox(width: 8.w),
                      ElevatedButton(
                        onPressed: loading
                            ? null
                            : () {
                          if (_formKey.currentState?.validate() != true) return;
                          context.read<UpdateTaskCubit>().update(
                            taskId: widget.task.id,
                            title: _title.text.trim(),
                            description: _desc.text.trim(),
                            status: _status,
                          );
                        },
                        child: loading
                            ? const SizedBox(
                            height: 18, width: 18, child: CustomCircularProgressIndicator())
                            : Text(loc.translate('Save')),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
