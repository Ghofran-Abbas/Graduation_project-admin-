import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/secretary_point_model.dart';

import '../../manager/update_secretary_points_cubit/update_secretary_points_cubit.dart';
import '../../manager/update_secretary_points_cubit/update_secretary_points_state.dart';

class EditSecretaryPointsDialog extends StatefulWidget {
  final SecretaryPoint secretary;
  const EditSecretaryPointsDialog({Key? key, required this.secretary}) : super(key: key);

  static Future<bool?> show(BuildContext context, SecretaryPoint secretary) {
    final updateCubit = context.read<UpdateSecretaryPointsCubit>();
    return showDialog<bool>(
      context: context,
      builder: (dialogCtx) => BlocProvider.value(
        value: updateCubit,
        child: EditSecretaryPointsDialog(secretary: secretary),
      ),
    );
  }

  @override
  State<EditSecretaryPointsDialog> createState() => _EditSecretaryPointsDialogState();
}

class _EditSecretaryPointsDialogState extends State<EditSecretaryPointsDialog> {
  late final TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.secretary.points.toString());
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
        TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final newPts = int.parse(_controller.text);
              context.read<UpdateSecretaryPointsCubit>().updatePoints(widget.secretary.id, newPts);
              Navigator.of(context).pop(true);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
