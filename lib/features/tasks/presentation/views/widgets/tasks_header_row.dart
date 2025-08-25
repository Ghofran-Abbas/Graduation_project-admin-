import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/localization/app_localizations.dart';

class TasksHeaderRow extends StatelessWidget {
  const TasksHeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelMedium?.copyWith(
      fontWeight: FontWeight.w700,
      color: Colors.black87,
    );
    final loc = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          Expanded(flex: 5, child: Text(loc.translate('Title'),     style: style)),
          Expanded(flex: 2, child: Text(loc.translate('Status'),    style: style)),
          Expanded(flex: 3, child: Text(loc.translate('Secretary'), style: style)),
          Expanded(flex: 3, child: Text(loc.translate('Created'),   style: style)),
          SizedBox(
            width: 88.w,
            child: Text(loc.translate('Actions'), style: style, textAlign: TextAlign.end),
          ),
        ],
      ),
    );
  }
}
