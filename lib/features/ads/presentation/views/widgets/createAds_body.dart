// lib/features/ads/presentation/views/widgets/add_announcement_dialog.dart

import 'dart:io';
import 'package:admin_alhadara_dashboard/core/utils/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../manager/getAllAdsCubit/addAd_state.dart';
import '../../manager/getAllAdsCubit/addAdd_cubit.dart';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';


class CreateAnnouncementBody extends StatefulWidget {
  @override
  State<CreateAnnouncementBody> createState() => CreateAnnouncementBodyState();
}

class CreateAnnouncementBodyState extends State<CreateAnnouncementBody> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  DateTime _start = DateTime.now();
  DateTime _end = DateTime.now().add(Duration(days: 30));
  String? _photoPath;     // mobile path
  Uint8List? _photoBytes; // web bytes

  Future<void> _pickImage() async {
    final res = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );
    if (res != null) {
      // On web we get bytes; on mobile we get path
      if (kIsWeb) {
        _photoBytes = res.files.single.bytes;
        _photoPath = null; // keep path null on web
      } else {
        _photoPath = res.files.single.path;
        _photoBytes = null;
      }
      setState(() {});
    }
  }

  Future<void> _pickDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _start : _end,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStart) _start = picked; else _end = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CreateAdCubit>().state;
    final cubit = context.read<CreateAdCubit>();
    final fmt = DateFormat('yyyy-MM-dd');

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  AppLocalizations.of(context).translate('Add announcement'),
                   style: Theme.of(context).textTheme.titleLarge),
            ),
            SizedBox(height: 16.h),

            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade200,
                ),
                child: _photoPath == null && _photoBytes == null
                    ? Icon(Icons.add_a_photo, size: 40.w, color: Colors.grey)
                    : (kIsWeb
                    ? CircleAvatar(radius: 60.w, backgroundImage: MemoryImage(_photoBytes!))
                    : CircleAvatar(radius: 60.w, backgroundImage: FileImage(File(_photoPath!)))),
              ),
            ),
            SizedBox(height: 24.h),

            Row(children: [
              Expanded(
                child: InkWell(
                  onTap: () => _pickDate(true),
                  child: InputDecorator(
                    decoration: InputDecoration(labelText:
                    AppLocalizations.of(context).translate('Start date'),
                    ),
                    child: Text(fmt.format(_start)),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: InkWell(
                  onTap: () => _pickDate(false),
                  child: InputDecorator(
                    decoration: InputDecoration(labelText:
                    AppLocalizations.of(context).translate('End date')
                    ),
                    child: Text(fmt.format(_end)),
                  ),
                ),
              ),
            ]),

            SizedBox(height: 16.h),

            TextField(
              controller: _descCtrl,
              maxLines: 4,
              decoration: InputDecoration(labelText:
              AppLocalizations.of(context).translate('Description')
              , border: OutlineInputBorder()),
            ),
            SizedBox(height: 16.h),

            TextField(
              controller: _titleCtrl,
              decoration: InputDecoration(labelText:
              AppLocalizations.of(context).translate('Title')
              , border: OutlineInputBorder()),
            ),
            SizedBox(height: 24.h),

            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(
                  AppLocalizations.of(context).translate('Cancel')
                  )),
              SizedBox(width: 12.w),
              ElevatedButton.icon(
                onPressed: () {
                  if (_photoPath == null && _photoBytes == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
                        AppLocalizations.of(context).translate('Please select a photo')
                        )));
                    return;
                  }

                  // Pass bytes on web, file path on mobile
                  cubit.createAd(
                    title: _titleCtrl.text.trim(),
                    description: _descCtrl.text.trim(),
                    photoFilePath: kIsWeb ? null : _photoPath,
                    photoBytes: kIsWeb ? _photoBytes : null,
                    startDate: _start,
                    endDate: _end,
                  );
                },
                icon: state is CreateAdLoading
                    ? SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Icon(Icons.add),
                label: Text(
                    AppLocalizations.of(context).translate('Add')
                    ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
