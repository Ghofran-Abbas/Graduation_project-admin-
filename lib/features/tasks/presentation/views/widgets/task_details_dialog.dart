import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/localization/app_localizations.dart';

class TaskDetailsDialog extends StatelessWidget {
  final String title;
  final String description;
  final String secretaryName;
  final String status;
  final String createdAt;

  const TaskDetailsDialog({
    super.key,
    required this.title,
    required this.description,
    required this.secretaryName,
    required this.status,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    final chipColor = theme.colorScheme.primary.withOpacity(.08);
    final chipBorder = theme.colorScheme.primary.withOpacity(.25);
    final chipText  = theme.colorScheme.primary;

    return AlertDialog(
      title: Text(loc.translate('Task Details'),
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
      content: SizedBox(
        width: 520.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                _Chip(label: loc.translate('Secretary'), value: secretaryName, chipColor: chipColor, chipBorder: chipBorder, chipText: chipText),
                _Chip(label: loc.translate('Status'),    value: status,        chipColor: chipColor, chipBorder: chipBorder, chipText: chipText),
                _Chip(label: loc.translate('Created'),   value: createdAt,     chipColor: chipColor, chipBorder: chipBorder, chipText: chipText),
              ],
            ),
            SizedBox(height: 14.h),
            Text(loc.translate('Description'), style: theme.textTheme.labelLarge),
            SizedBox(height: 6.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.03),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: SelectableText(
                description.isEmpty ? '—' : description,
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text(loc.translate('Close'))),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final String value;
  final Color chipColor;
  final Color chipBorder;
  final Color chipText;

  const _Chip({
    required this.label,
    required this.value,
    required this.chipColor,
    required this.chipBorder,
    required this.chipText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: chipBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(value, style: TextStyle(color: chipText, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
