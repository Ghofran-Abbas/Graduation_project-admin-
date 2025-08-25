import 'package:admin_alhadara_dashboard/features/tasks/presentation/views/widgets/secretary_picker_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../core/widgets/custom_snack_bar.dart';
import '../../manager/create_task_cubit/create_task_cubit.dart';
import '../../manager/create_task_cubit/create_task_state.dart';

class CreateTaskDialog extends StatefulWidget {
  const CreateTaskDialog({super.key});

  @override
  State<CreateTaskDialog> createState() => _CreateTaskDialogState();
}

class _CreateTaskDialogState extends State<CreateTaskDialog> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _desc = TextEditingController();
  int? _selectedSecretaryId;
  String? _selectedSecretaryName;

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
      title: Text(loc.translate('Create Task')),
      content: BlocConsumer<CreateTaskCubit, CreateTaskState>(
        listener: (context, state) {
          if (state is CreateTaskFailure) {
            CustomSnackBar.showErrorSnackBar(context, msg: state.error);
          }
          if (state is CreateTaskSuccess) {
            Navigator.pop(context, true);
          }
        },
        builder: (context, state) {
          final loading = state is CreateTaskLoading;
          return SizedBox(
            width: 420.w,
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
                    validator: (v) =>
                    (v == null || v.trim().isEmpty) ? loc.translate('Required') : null,
                  ),
                  SecretaryPickerField(
                    label: loc.translate('Secretary'),
                    initialSecretaryId: _selectedSecretaryId,
                    initialSecretaryName: _selectedSecretaryName,
                    validator: (_) =>
                    (_selectedSecretaryId == null)
                        ? loc.translate('Please pick a secretary')
                        : null,
                    onSelected: (employee) {
                      _selectedSecretaryId = employee.id;
                      _selectedSecretaryName = employee.name;
                      setState(() {});
                    },
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
                          context.read<CreateTaskCubit>().create(
                            title: _title.text.trim(),
                            description: _desc.text.trim(),
                            secretaryId: _selectedSecretaryId!,
                          );
                        },
                        child: loading
                            ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CustomCircularProgressIndicator(),
                        )
                            : Text(loc.translate('Create')),
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
