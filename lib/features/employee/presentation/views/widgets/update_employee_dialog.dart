// lib/features/employee/presentation/views/widgets/update_employee_dialog.dart

import 'package:flutter/material.dart';
import 'dart:typed_data' show Uint8List;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../../data/models/employees_model.dart';
import '../../manager/update_employee_cubit/update_employee_cubit.dart';
import '../../manager/update_employee_cubit/update_employee_state.dart';

class UpdateEmployeeDialog extends StatefulWidget {
  final Employee employee;
  const UpdateEmployeeDialog({Key? key, required this.employee}) : super(key: key);

  @override
  State<UpdateEmployeeDialog> createState() => _UpdateEmployeeDialogState();
}

class _UpdateEmployeeDialogState extends State<UpdateEmployeeDialog> {
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
    final e = widget.employee;
    _nameC     = TextEditingController(text: e.name);
    _emailC    = TextEditingController(text: e.email);
    _phoneC    = TextEditingController(text: e.phone);
    _birthdayC = TextEditingController(text: e.birthday);
    _genderC   = TextEditingController(text: e.gender);
    _roleC     = TextEditingController(text: e.role);
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
    context.read<UpdateEmployeeCubit>().fetchUpdateEmployee(
      id:         widget.employee.id,
      name:       _nameC.text,

      photoBytes: _photoBytes,
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(loc?.translate('Edit Employee') ?? 'Edit Employee'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickPhoto,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage:
                  _photoBytes != null ? MemoryImage(_photoBytes!) : null,
                  child:
                  _photoBytes == null ? const Icon(Icons.add_a_photo) : null,
                ),
              ),
              const SizedBox(height: 12),
              for (final entry in <MapEntry<TextEditingController, String>>[
                MapEntry(_nameC, 'Full Name'),

              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: TextFormField(
                    controller: entry.key,
                    decoration: InputDecoration(
                      labelText: loc?.translate(entry.value) ?? entry.value,
                    ),
                    validator: (v) =>
                    v!.isEmpty ? loc?.translate('Required') ?? 'Required' : null,
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
        BlocListener<UpdateEmployeeCubit, UpdateEmployeeState>(
          listener: (_, state) {
            if (state is UpdateEmployeeSuccess) {
              Navigator.pop(context, true);
            }
            if (state is UpdateEmployeeFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: ElevatedButton(
            child: Text(loc?.translate('Save') ?? 'Save'),
            onPressed: _submit,
          ),
        ),
      ],
    );
  }
}
