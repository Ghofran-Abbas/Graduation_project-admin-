// lib/features/employee/presentation/views/widgets/create_employee_dialog.dart

import 'package:flutter/material.dart';
import 'dart:typed_data' show Uint8List;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../manager/create_employee_cubit/create_employee_cubit.dart';
import '../../manager/create_employee_cubit/create_employee_state.dart';

class CreateEmployeeDialog extends StatefulWidget {
  const CreateEmployeeDialog({Key? key}) : super(key: key);

  @override
  State<CreateEmployeeDialog> createState() => _CreateEmployeeDialogState();
}

class _CreateEmployeeDialogState extends State<CreateEmployeeDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameC     = TextEditingController();
  final _emailC    = TextEditingController();
  final _phoneC    = TextEditingController();
  final _birthdayC = TextEditingController();
  final _genderC   = TextEditingController();
  Uint8List? _photoBytes;

  // Dropdown state:
  final List<String> roles = ['Security', 'Accountant', 'Buffer'];
  String? _selectedRole;

  @override
  void dispose() {
    for (final c in [_nameC, _emailC, _phoneC, _birthdayC, _genderC]) {
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

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final initial = now.subtract(const Duration(days: 365 * 20));
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      _birthdayC.text = DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<CreateEmployeeCubit>().createEmployee(
      name:       _nameC.text.trim(),
      email:      _emailC.text.trim(),
      phone:      _phoneC.text.trim(),
      birthday:   _birthdayC.text.trim(),
      gender:     _genderC.text.trim(),
      role:       _selectedRole!.trim(),
      photoBytes: _photoBytes,
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(loc.translate('Add Employee')),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Photo
              GestureDetector(
                onTap: _pickPhoto,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage:
                  _photoBytes != null ? MemoryImage(_photoBytes!) : null,
                  child: _photoBytes == null
                      ? const Icon(Icons.add_a_photo)
                      : null,
                ),
              ),
              const SizedBox(height: 12),

              // Full Name
              TextFormField(
                controller: _nameC,
                decoration:
                InputDecoration(labelText: loc.translate('Full Name')),
                validator: (v) =>
                v == null || v.trim().isEmpty ? loc.translate('Required') : null,
              ),

              // Email
              TextFormField(
                controller: _emailC,
                decoration: InputDecoration(labelText: loc.translate('Email')),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return loc.translate('Required');
                  }
                  final email = v.trim();
                  if (!email.contains('@') || !email.endsWith('.com')) {
                    return loc.translate('Enter a valid email');
                  }
                  return null;
                },
              ),

              // Phone
              TextFormField(
                controller: _phoneC,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: loc.translate('Phone')),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return loc.translate('Required');
                  }
                  final len = v.trim().length;
                  if (len < 10 || len > 12) {
                    return loc.translate('Phone must be 10–12 digits');
                  }
                  return null;
                },
              ),

              // Birthday
              TextFormField(
                controller: _birthdayC,
                readOnly: true,
                decoration: InputDecoration(labelText: loc.translate('Birthday')),
                onTap: _pickDate,
                validator: (v) =>
                v == null || v.trim().isEmpty ? loc.translate('Required') : null,
              ),

              // Gender
              TextFormField(
                controller: _genderC,
                decoration: InputDecoration(labelText: loc.translate('Gender')),
                validator: (v) =>
                v == null || v.trim().isEmpty ? loc.translate('Required') : null,
              ),

              const SizedBox(height: 12),

              // Role (dropdown)
              DropdownButtonFormField<String>(
                value: _selectedRole,
                decoration: InputDecoration(labelText: loc.translate('Role')),
                items: roles
                    .map((r) => DropdownMenuItem(
                  value: r,
                  child: Text(loc.translate(r)),
                ))
                    .toList(),
                onChanged: (val) => setState(() => _selectedRole = val),
                validator: (v) =>
                v == null || v.isEmpty ? loc.translate('Required') : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text(loc.translate('Cancel')),
          onPressed: () => Navigator.pop(context, false),
        ),
        BlocListener<CreateEmployeeCubit, CreateEmployeeState>(
          listener: (ctx, state) {
            if (state is CreateEmployeeSuccess) {
              Navigator.pop(ctx, true);
            } else if (state is CreateEmployeeFailure) {
              ScaffoldMessenger.of(ctx).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: BlocBuilder<CreateEmployeeCubit, CreateEmployeeState>(
            builder: (ctx, state) {
              if (state is CreateEmployeeLoading) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              }
              return ElevatedButton(
                child: Text(loc.translate('Add')),
                onPressed: _submit,
              );
            },
          ),
        ),
      ],
    );
  }
}
