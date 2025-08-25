// lib/features/ads/presentation/views/widgets/update_announcement_body.dart

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_network/image_network.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../data/models/ad_detail_model.dart';
import '../../../data/models/ad_model.dart';
import '../../manager/getAllAdsCubit/updateAd_cubit.dart';
import '../../manager/getAllAdsCubit/updateAd_state.dart';



class UpdateAnnouncementBody extends StatefulWidget {
  final   AdModel ad;
  const UpdateAnnouncementBody({Key? key, required this.ad}) : super(key: key);

  @override
  State<UpdateAnnouncementBody> createState() => _UpdateAnnouncementBodyState();
}

class _UpdateAnnouncementBodyState extends State<UpdateAnnouncementBody> {
  late TextEditingController _titleCtrl;
  late TextEditingController _descCtrl;
  late DateTime _start;
  late DateTime _end;

  // عند التعديل نسمح بتبديل الصورة
  String? _newPhotoPath;
  Uint8List? _newPhotoBytes;
  String? _newPhotoName;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: widget.ad.title);
    _descCtrl  = TextEditingController(text: widget.ad.description);
    _start     = widget.ad.startDate;
    _end       = widget.ad.endDate;
  }

  Future<void> _pickImage() async {
    final res = await FilePicker.platform.pickFiles(type: FileType.image, withData: true);
    if (res != null) {
      setState(() {
        if (kIsWeb) {
          _newPhotoBytes = res.files.single.bytes;
          _newPhotoName  = res.files.single.name;
        } else {
          _newPhotoPath = res.files.single.path;
          _newPhotoName = res.files.single.name;
        }
      });
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
    final cubit = context.read<UpdateAdCubit>();
    final state = context.watch<UpdateAdCubit>().state;
    final fmt   = DateFormat('yyyy‑MM‑dd');
    final photoUrl = widget.ad.photo.isNotEmpty
        ? 'http://127.0.0.1:8000/${widget.ad.photo}'
        : null;
    print("photo=$photoUrl");

    Widget avatar = Stack(
      alignment: Alignment.center,
      children: [
        // الدائرة التي تعرض الصورة قديمة (ImageNetwork) أو الصورة الجديدة
        CircleAvatar(
          radius: 60.w,
          backgroundColor: AppColors.w1,
          child: ClipOval(
            child: SizedBox(
              width: 120.w,
              height: 120.w,
              child: (_newPhotoPath != null || _newPhotoBytes != null)
                  ? (kIsWeb
                  ? Image.memory(_newPhotoBytes!, fit: BoxFit.cover)
                  : Image.file(File(_newPhotoPath!), fit: BoxFit.cover))
                  : (photoUrl != null
                  ? ImageNetwork(
                image: photoUrl,
                fitAndroidIos: BoxFit.cover,
                borderRadius: BorderRadius.zero,   width: 200,
                height: 200,
              )
                  : Icon(Icons.person, size: 80.r)),
            ),
          ),
        ),

        // أيقونة الكاميرا في الأسفل ليميز المستخدم بامكانية التغيير
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(4.r),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.camera_alt_outlined, color: AppColors.purple, size: 20.r),
          ),
        ),

        // تغطية العنصر كله بـ InkWell لالتقاط الضغط
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(60.w),
              onTap: _pickImage,
            ),
          ),
        ),
      ],
    );

    // اختيار الصورة: إذا اختار المستخدم صورة جديدة نعرضها، وإلا نعرض الشبكة
    // Widget avatar;
    // if (_newPhotoPath == null && _newPhotoBytes == null) {
    //   // عرض الصورة القديمة من الـ URL
    //   avatar =
    //       CircleAvatar(
    //         radius: 150.r,
    //         backgroundColor: AppColors.w1,
    //         child: ClipOval(
    //           child: photoUrl != null
    //               ? ImageNetwork(
    //             image: photoUrl,
    //             width: 200,
    //             height: 200,
    //             fitAndroidIos: BoxFit.cover,
    //           )
    //               : Icon(Icons.person, size: 80.r),
    //         ),
    //       );

    // } else if (kIsWeb && _newPhotoBytes != null) {
    //   avatar = CircleAvatar(radius: 60.w, backgroundImage: MemoryImage(_newPhotoBytes!));
    // } else {
    //   avatar = CircleAvatar(radius: 60.w, backgroundImage: FileImage(File(_newPhotoPath!)));
    // }

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
                AppLocalizations.of(context).translate('Edit announcement')
                , style: Theme.of(context).textTheme.titleLarge),
          ),
          SizedBox(height: 16.h),
          GestureDetector(onTap: _pickImage, child: avatar),
          SizedBox(height: 24.h),

          // تواريخ البداية والنهاية
          Row(children: [
            Expanded(
              child: InkWell(
                onTap: () => _pickDate(true),
                child: InputDecorator(
                  decoration: InputDecoration(labelText:
                  AppLocalizations.of(context).translate('Start date')
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

          // الوصف
          TextField(
            controller: _descCtrl,
            maxLines: 4,
            decoration: InputDecoration(labelText:
            AppLocalizations.of(context).translate('Description')
            , border: OutlineInputBorder()),
          ),
          SizedBox(height: 16.h),

          // العنوان
          TextField(
            controller: _titleCtrl,
            decoration: InputDecoration(labelText:
            AppLocalizations.of(context).translate('Title')
            , border: OutlineInputBorder()),
          ),
          SizedBox(height: 24.h),

          // أزرار الحفظ والإلغاء
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(
                AppLocalizations.of(context).translate('Cancel')
                )),
            SizedBox(width: 12.w),
            ElevatedButton.icon(
              onPressed: state is UpdateAdLoading ? null : () {
                cubit.updateAd(
                  id: widget.ad.id,
                  title: _titleCtrl.text.trim(),
                  description: _descCtrl.text.trim(),
                  startDate: _start,
                  endDate: _end,
                  // نمرر ملفات الصورة الجديدة فقط إن وجدت
                  photoFilePath: _newPhotoPath,
                  photoBytes: _newPhotoBytes,
                  photoFileName: _newPhotoName,
                );
              },
              icon: state is UpdateAdLoading
                  ? SizedBox(width:16, height:16, child:CircularProgressIndicator(strokeWidth:2, color:Colors.white))
                  : Icon(Icons.check),
              label: Text(
                  AppLocalizations.of(context).translate('Save')
                  ),
            ),
          ]),
        ]),
      ),
    );
  }
}
