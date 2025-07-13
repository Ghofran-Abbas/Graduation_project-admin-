
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/styles.dart';

/// A simple header + list wrapper for "Name / Points / Edit"
class CustomListInformationFieldsForPoints extends StatelessWidget {
  const CustomListInformationFieldsForPoints({
    super.key,
    required this.widget,
    this.showSecondField = false,
  });

  /// Whether to show the second column header
  final bool showSecondField;

  /// The ListView underneath the header
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Container(
            height: 48.h,
            color: AppColors.white,
            child: Row(
              children: [
                // Name (3/6 of width)
                const Expanded(
                  flex: 3,
                  child: _HeaderText('Name'),
                ),

                // Points (2/6 of width)
                if (showSecondField)
                  const Expanded(
                    flex: 2,
                    child: _HeaderText('Points'),
                  ),

                // Spacer for icon column
                const SizedBox(width: 48),
              ],
            ),
          ),
        ),
        SizedBox(height: 8.h),
        widget,
        SizedBox(height: 16.h),
      ],
    );
  }
}

class _HeaderText extends StatelessWidget {
  final String label;
  const _HeaderText(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context).translate(label),
      style: Styles.l2Medium(color: AppColors.t3),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}