// lib/features/employee/presentation/views/widgets/register_secretary_dialog.dart

import 'package:flutter/material.dart';
import 'dart:typed_data' show Uint8List;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../manager/register_secretary_cubit/register_secretary_cubit.dart';
import '../../manager/register_secretary_cubit/register_secretary_state.dart';

class RegisterSecretaryDialog extends StatefulWidget {
  const RegisterSecretaryDialog({Key? key}) : super(key: key);

  @override
  _RegisterSecretaryDialogState createState() =>
      _RegisterSecretaryDialogState();
}

class _RegisterSecretaryDialogState extends State<RegisterSecretaryDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameC     = TextEditingController();
  final _emailC    = TextEditingController();
  final _passwordC = TextEditingController();
  final _phoneC    = TextEditingController();
  final _birthdayC = TextEditingController();
  final _genderC   = TextEditingController();
  Uint8List? _photoBytes;

  @override
  void dispose() {
    for (final c in [
      _nameC,
      _emailC,
      _passwordC,
      _phoneC,
      _birthdayC,
      _genderC
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final res = await FilePicker.platform.pickFiles(
        type: FileType.image, withData: true);
    if (res != null && res.files.single.bytes != null) {
      setState(() => _photoBytes = res.files.single.bytes!);
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
        context: context,
        initialDate: now.subtract(const Duration(days: 365 * 20)),
        firstDate: DateTime(1900),
        lastDate: now);
    if (picked != null) {
      _birthdayC.text = DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<RegisterSecretaryCubit>().register(
      name:     _nameC.text.trim(),
      email:    _emailC.text.trim(),
      password: _passwordC.text.trim(),
      phone:    _phoneC.text.trim(),
      birthday: _birthdayC.text.trim(),
      gender:   _genderC.text.trim(),
      photoBytes: _photoBytes,
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(loc.translate('Register Secretary')),
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
                  child: _photoBytes == null
                      ? const Icon(Icons.add_a_photo)
                      : null,
                ),
              ),
              const SizedBox(height: 12),
              // Full Name
              TextFormField(
                controller: _nameC,
                decoration: InputDecoration(
                  labelText: loc.translate('Full Name'),
                ),
                validator: (v) =>
                v == null || v.trim().isEmpty ? loc.translate('Required') : null,
              ),
              // Email
              TextFormField(
                controller: _emailC,
                decoration: InputDecoration(
                  labelText: loc.translate('Email'),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return loc.translate('Required');
                  final email = v.trim();
                  if (!email.contains('@') || !email.endsWith('.com')) {
                    return loc.translate('Enter a valid email');
                  }
                  return null;
                },
              ),
              // Password
              TextFormField(
                controller: _passwordC,
                decoration: InputDecoration(
                  labelText: loc.translate('Password'),
                ),
                obscureText: true,
                validator: (v) {
                  if (v == null || v.isEmpty) return loc.translate('Required');
                  if (v.length < 8) return loc.translate('Password must be at least 8 characters');
                  return null;
                },
              ),
              // Phone
              TextFormField(
                controller: _phoneC,
                decoration: InputDecoration(
                  labelText: loc.translate('Phone'),
                ),
                keyboardType: TextInputType.phone,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return loc.translate('Required');
                  if (v.trim().length < 10) return loc.translate('Phone must be at least 10 digits');
                  return null;
                },
              ),
              // Birthday
              TextFormField(
                controller: _birthdayC,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: loc.translate('Birthday'),
                ),
                onTap: _pickDate,
                validator: (v) =>
                v == null || v.trim().isEmpty ? loc.translate('Required') : null,
              ),
              // Gender
              TextFormField(
                controller: _genderC,
                decoration: InputDecoration(
                  labelText: loc.translate('Gender'),
                ),
                validator: (v) =>
                v == null || v.trim().isEmpty ? loc.translate('Required') : null,
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
        BlocConsumer<RegisterSecretaryCubit, RegisterSecretaryState>(
          listener: (context, state) {
            if (state is RegisterSecretarySuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.result.message)),
              );
              Navigator.pop(context, true);
            } else if (state is RegisterSecretaryFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            if (state is RegisterSecretaryLoading) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              );
            }
            return ElevatedButton(
              child: Text(loc.translate('Register')),
              onPressed: _submit,
            );
          },
        ),
      ],
    );
  }
}
