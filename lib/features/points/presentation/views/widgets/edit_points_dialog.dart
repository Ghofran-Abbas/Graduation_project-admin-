
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../features/points/data/models/student_point_model.dart';
import '../../../../../features/points/presentation/manager/update_points_cubit/update_points_cubit.dart';

class EditPointsDialog extends StatefulWidget {
  const EditPointsDialog({
    super.key,
    required this.student,
  });

  final StudentPoint student;

  /// Shows the dialog and returns true if saved, false if cancelled.
  static Future<bool?> show(BuildContext context, StudentPoint student) {
    final updateCubit = context.read<UpdatePointsCubit>();
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: updateCubit,
        child: EditPointsDialog(student: student),
      ),
    );
  }

  @override
  State<EditPointsDialog> createState() => _EditPointsDialogState();
}

class _EditPointsDialogState extends State<EditPointsDialog> {
  late TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.student.points.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Points'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Points'),
          validator: (v) {
            if (v == null || v.isEmpty) return 'Required';
            if (int.tryParse(v) == null) return 'Must be a number';
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              final newPts = int.parse(_controller.text);
              context.read<UpdatePointsCubit>().updatePoints(widget.student.id, newPts);
              Navigator.of(context).pop(true);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
