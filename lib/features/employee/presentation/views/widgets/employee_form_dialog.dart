// lib/features/employee/presentation/views/widgets/employee_form_dialog.dart

import 'package:flutter/material.dart';
import 'dart:typed_data' show Uint8List;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../../data/models/employees_model.dart';
import '../../manager/create_employee_cubit/create_employee_cubit.dart';
import '../../manager/create_employee_cubit/create_employee_state.dart';
import '../../manager/update_employee_cubit/update_employee_cubit.dart';
import '../../manager/update_employee_cubit/update_employee_state.dart';

class EmployeeFormDialog extends StatefulWidget {
  /// If non-null, we’re editing.
  final Employee? employee;
  const EmployeeFormDialog({Key? key, this.employee}) : super(key: key);

  @override
  State<EmployeeFormDialog> createState() => _EmployeeFormDialogState();
}

class _EmployeeFormDialogState extends State<EmployeeFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController
  _nameC,
      _emailC,
      _phoneC,
      _birthdayC,
      _genderC,
      _roleC;
  Uint8List? _photoBytes;

  @override
  void initState() {
    super.initState();
    _nameC     = TextEditingController(text: widget.employee?.name);
    _emailC    = TextEditingController(text: widget.employee?.email);
    _phoneC    = TextEditingController(text: widget.employee?.phone);
    _birthdayC = TextEditingController(text: widget.employee?.birthday);
    _genderC   = TextEditingController(text: widget.employee?.gender);
    _roleC     = TextEditingController(text: widget.employee?.role);
  }

  @override
  void dispose() {
    for (final c in [_nameC, _emailC, _phoneC, _birthdayC, _genderC, _roleC]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final res = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );
    if (res != null && res.files.single.bytes != null) {
      setState(() => _photoBytes = res.files.single.bytes!);
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final isEditing = widget.employee != null;
    if (!isEditing && _photoBytes == null) return;

    if (isEditing) {
      context.read<UpdateEmployeeCubit>().fetchUpdateEmployee(
        id:         widget.employee!.id,
        name:       _nameC.text,

        photoBytes: _photoBytes,
      );
    } else {
      context.read<CreateEmployeeCubit>().createEmployee(
        name:       _nameC.text,
        email:      _emailC.text,
        phone:      _phoneC.text,
        birthday:   _birthdayC.text,
        gender:     _genderC.text,
        role:       _roleC.text,
        photoBytes: _photoBytes!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc       = AppLocalizations.of(context);
    final isEditing = widget.employee != null;

    final fields = <MapEntry<TextEditingController, String>>[
      MapEntry(_nameC, 'Full Name'),
      MapEntry(_emailC, 'Email'),
      MapEntry(_phoneC, 'Phone'),
      MapEntry(_birthdayC, 'Birthday'),
      MapEntry(_genderC, 'Gender'),
      MapEntry(_roleC, 'Role'),
    ];

    return AlertDialog(
      title: Text(
        isEditing
            ? loc?.translate('Edit Employee') ?? 'Edit Employee'
            : loc?.translate('Add Employee')  ?? 'Add Employee',
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickPhoto,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: _photoBytes != null
                      ? MemoryImage(_photoBytes!)
                      : null,
                  child: _photoBytes == null
                      ? const Icon(Icons.add_a_photo)
                      : null,
                ),
              ),
              const SizedBox(height: 12),
              for (final entry in fields)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: TextFormField(
                    controller: entry.key,
                    decoration: InputDecoration(
                      labelText: loc?.translate(entry.value) ?? entry.value,
                    ),
                    validator: (v) => v!.isEmpty
                        ? loc?.translate('Required') ?? 'Required'
                        : null,
                  ),
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text(loc?.translate('Cancel') ?? 'Cancel'),
          onPressed: () => Navigator.pop(context, false),
        ),
        BlocListener<CreateEmployeeCubit, CreateEmployeeState>(
          listener: (_, state) {
            if (state is CreateEmployeeSuccess) Navigator.pop(context, true);
            if (state is CreateEmployeeFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: BlocListener<UpdateEmployeeCubit, UpdateEmployeeState>(
            listener: (_, state) {
              if (state is UpdateEmployeeSuccess) Navigator.pop(context, true);
              if (state is UpdateEmployeeFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            child: ElevatedButton(
              child: Text(
                isEditing
                    ? loc?.translate('Save') ?? 'Save'
                    : loc?.translate('Add')  ?? 'Add',
              ),
              onPressed: _submit,
            ),
          ),
        ),
      ],
    );
  }
}
