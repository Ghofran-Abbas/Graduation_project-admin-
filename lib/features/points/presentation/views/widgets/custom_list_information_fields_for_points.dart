import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/styles.dart';

/// Use the same width for the trailing actions column (header & rows)
const double _kActionColWidth = 48.0;

class CustomListInformationFieldsForPoints extends StatelessWidget {
  const CustomListInformationFieldsForPoints({
    super.key,
    required this.widget,
    this.showSecondField = false,
  });

  final bool showSecondField;
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
                Expanded(
                  flex: 3,
                  child: _HeaderText('Name'),
                ),
                // Points (2/6 of width)
                if (showSecondField)
                  Expanded(
                    flex: 2,
                    child: _HeaderText('Points'),
                  ),
                // Fixed space matching the row's trailing icon column
                SizedBox(width: _kActionColWidth.w),
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
    // Align to start so it looks right in both LTR/RTL
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        AppLocalizations.of(context).translate(label),
        style: Styles.l2Medium(color: AppColors.t3),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
