import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/localization/app_localizations.dart';

class TaskRow extends StatelessWidget {
  final String title;
  final String status;
  final String assignee;
  final String createdAt;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const TaskRow({
    super.key,
    required this.title,
    required this.status,
    required this.assignee,
    required this.createdAt,
    this.onEdit,
    this.onDelete,
    this.onTap,
  });

  Color _statusColor() {
    switch (status.toLowerCase()) {
      case 'done':
      case 'completed':
        return Colors.green;
      case 'in_progress':
        return Colors.orange;
      default:
        return Colors.deepPurple;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.black12),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: BoxDecoration(color: _statusColor(), shape: BoxShape.circle),
                    ),
                    SizedBox(width: 6.w),
                    Text(status, style: TextStyle(fontSize: 12.sp)),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  assignee,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12.sp, color: Colors.black87),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(createdAt, style: TextStyle(fontSize: 12.sp, color: Colors.black54)),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_rounded),
                    tooltip: loc.translate('Edit'),
                    onPressed: onEdit,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline_rounded),
                    tooltip: loc.translate('Delete'),
                    onPressed: onDelete,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
