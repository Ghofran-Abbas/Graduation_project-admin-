import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../data/models/gift_model.dart';
import '../../manager/create_gift_cubit/create_gift_cubit.dart';
import '../../manager/create_gift_cubit/create_gift_state.dart';
import '../../manager/update_gift_cubit/update_gift_cubit.dart';
import '../../manager/update_gift_cubit/update_gift_state.dart';

class GiftFormDialog extends StatefulWidget {
  /// Provide exactly one of these:
  final int? studentId;
  final int? secretaryId;
  final Gift? existing;

  const GiftFormDialog({
    Key? key,
    this.studentId,
    this.secretaryId,
    this.existing,
  })  : assert((studentId == null) ^ (secretaryId == null),
  'Must provide exactly one of studentId or secretaryId'),
        super(key: key);

  @override
  _GiftFormDialogState createState() => _GiftFormDialogState();
}

class _GiftFormDialogState extends State<GiftFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _descC;
  late final TextEditingController _dateC;
  Uint8List? _photo;

  @override
  void initState() {
    super.initState();
    _descC =
        TextEditingController(text: widget.existing?.description ?? '');
    _dateC = TextEditingController(
      text: widget.existing != null
          ? DateFormat('yyyy-MM-dd').format(widget.existing!.date)
          : '',
    );
  }

  @override
  void dispose() {
    _descC.dispose();
    _dateC.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.image, withData: true);
    if (result != null && result.files.single.bytes != null) {
      setState(() => _photo = result.files.single.bytes);
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final isEdit = widget.existing != null;

    if (isEdit) {
      context.read<UpdateGiftCubit>().updateGift(
        id: widget.existing!.id,
        description: _descC.text,
        date: DateTime.parse(_dateC.text),
        photoBytes: _photo,
        // you can pass studentId/secretaryId here if you truly need to reassign
      );
    } else {
      context.read<CreateGiftCubit>().createGift(
        description: _descC.text,
        date: DateTime.parse(_dateC.text),
        studentId: widget.studentId,
        secretaryId: widget.secretaryId,
        photoBytes: _photo,
      );
    }
  }

  @override
  Widget build(BuildContext ctx) {
    return AlertDialog(
      title:
      Text(widget.existing == null ? 'New Award' : 'Edit Award'),
      content: Form(
        key: _formKey,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextFormField(
            controller: _descC,
            decoration: const InputDecoration(labelText: 'Description'),
            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
          ),
          TextFormField(
            controller: _dateC,
            decoration: const InputDecoration(
              labelText: 'Date',
              suffixIcon: Icon(Icons.calendar_today),
            ),
            readOnly: true,
            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            onTap: () async {
              // show the date picker
              final picked = await showDatePicker(
                context: context,
                initialDate: widget.existing?.date ?? DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                // format and store
                _dateC.text = DateFormat('yyyy-MM-dd').format(picked);
              }
            },
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: _pickPhoto,
            child: CircleAvatar(
              radius: 30,
              backgroundImage:
              _photo != null ? MemoryImage(_photo!) : null,
              child: _photo == null
                  ? const Icon(Icons.photo)
                  : null,
            ),
          ),
        ]),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel')),
        BlocListener<CreateGiftCubit, CreateGiftState>(
          listener: (_, state) {
            if (state is CreateGiftSuccess) Navigator.pop(ctx, true);
          },
          child: BlocListener<UpdateGiftCubit, UpdateGiftState>(
            listener: (_, state) {
              if (state is UpdateGiftSuccess) Navigator.pop(ctx, true);
            },
            child: ElevatedButton(
              onPressed: _submit,
              child: Text(
                  widget.existing == null ? 'Create' : 'Save'),
            ),
          ),
        ),
      ],
    );
  }
}
