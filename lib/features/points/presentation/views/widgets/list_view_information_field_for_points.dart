import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/widgets/custom_icon_button.dart';

const double _kActionColWidth = 48.0;

class InformationFieldItemForPoints extends StatelessWidget {
  const InformationFieldItemForPoints({
    super.key,
    this.color,
    required this.name,
    this.nameColor,
    required this.secondText,
    this.secondTextColor,
    required this.onEditTap,
  });

  final Color? color;
  final String name;
  final Color? nameColor;
  final String secondText;
  final Color? secondTextColor;
  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? AppColors.white,
      height: 66.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          // Name (flex:3)
          Expanded(
            flex: 3,
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                name,
                style: Styles.l2Medium(color: nameColor ?? AppColors.t3),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // Points (flex:2)
          Expanded(
            flex: 2,
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                secondText,
                style: Styles.l2Medium(color: secondTextColor ?? AppColors.t3),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // Trailing action with the same fixed width as header
          SizedBox(
            width: _kActionColWidth.w,
            child: Align(
              alignment: Alignment.centerLeft,
              child: CustomIconButton(
                icon: Icons.edit_outlined,
                onTap: onEditTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
