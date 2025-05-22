import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../features/secretary_features/student/data/models/students_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/styles.dart';
import '../custom_icon_button.dart';
import '../custom_image_network.dart';

class InformationFieldItem extends StatelessWidget {
  const InformationFieldItem({
    super.key, this.width, this.height, this.color, this.image, this.imageWidth, this.imageHeight, this.imageBorderRadius, this.widthProfileText, required this.name, this.nameColor, this.showDetailsText, this.secondText, this.secondTextColor, this.showSecondDetailsText, this.thirdDetailsText, this.thirdDetailsTextColor, this.showIcons, this.heightTextIcon, this.leftIcon, this.rightIcon, required this.onTap, this.fourthDetailsText, this.fourthDetailsTextColor, required this.onTapFirstIcon, required this.onTapSecondIcon, this.fifthText, this.fifthTextColor, this.showFifthDetailsText, this.showJustTowDetailsText, this.showFirstBox, this.hideFirstIcon, this.showSecondBox, this.hideSecondIcon, this.onTapFirstBox, this.onTapSecondBox, this.isReportStyle, this.isComplainStyle,
  });

  final double? width;
  final double? height;
  final Color? color;
  final String? image;
  final double? imageWidth;
  final double? imageHeight;
  final double? imageBorderRadius;
  final double? widthProfileText;
  final String name;
  final Color? nameColor;
  final bool? showDetailsText;
  final String? secondText;
  final Color? secondTextColor;
  final bool? showSecondDetailsText;
  final String? thirdDetailsText;
  final Color? thirdDetailsTextColor;
  final String? fourthDetailsText;
  final Color? fourthDetailsTextColor;
  final String? fifthText;
  final Color? fifthTextColor;
  final bool? showFifthDetailsText;
  final bool? showJustTowDetailsText;
  final bool? showIcons;
  final bool? hideFirstIcon;
  final bool? hideSecondIcon;
  final double? heightTextIcon;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final Function onTap;
  final Function onTapFirstIcon;
  final Function onTapSecondIcon;
  final Function? onTapFirstBox;
  final Function? onTapSecondBox;
  final bool? showFirstBox;
  final bool? showSecondBox;
  final bool? isReportStyle;
  final bool? isComplainStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        padding: EdgeInsets.only(left: 7.0.w, right: 37.0.w),
        width: width ?? 1151.24.w,
        height: height ?? 66.h,
        decoration: BoxDecoration(
          color: color ?? AppColors.white,
        ),
        child: isReportStyle ?? false ? Row(
          children: [
            isComplainStyle ?? false ? SizedBox(width: 0, height: 0,) : Expanded(
              flex: 2,
              child: Row(
                children: [
                  //image
                  image != null ? CustomImageNetwork(
                    imageWidth: imageWidth ?? 24.w,
                    imageHeight: imageHeight ?? 24.w,
                    borderRadius: imageBorderRadius ?? 30.r,
                    image: image,
                  ) : CustomImageAsset(
                    imageWidth: imageWidth ?? 24.w,
                    imageHeight: imageHeight ?? 24.w,
                    borderRadius: imageBorderRadius ?? 30.r,
                  ),
                  //Information
                  SizedBox(width: widthProfileText ?? 8.12.w,),
                  Expanded(
                    child: Text(
                      name,
                      style: Styles.l2Medium(color: nameColor ?? AppColors.t3),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            isComplainStyle ?? false ? SizedBox(width: 0, height: 0,) : SizedBox(width: 20.w,),
            Expanded(
              flex: 8,
              child: Text(
                secondText ?? '',
                style: Styles.l2Medium(color: secondTextColor ?? AppColors.t3),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 30.w,),
            Expanded(
              flex: 1,
              child: Text(
                fifthText ?? '',
                style: Styles.l2Medium(color: fifthTextColor ?? AppColors.darkLightPurple),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            //Action icons
            SizedBox(width: 20.0.h,),
            showIcons ?? false ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                hideFirstIcon ?? false ? SizedBox(width: 25.w, height: 0.h,) : CustomIconButton(icon: leftIcon ?? Icons.edit_outlined, onTap: (){onTapFirstIcon();},),
                SizedBox(width: 10.8.w,),
                hideSecondIcon ?? false ? SizedBox(width: 25.w, height: 0.h,) : CustomIconButton(icon: rightIcon ?? Icons.delete_outline, onTap: (){onTapSecondIcon();},),
              ],
            ) : SizedBox(width: 0, height: 0,),
          ],
        ) : Row(
          children: [
            Expanded(
              flex: showFirstBox ?? false ? showFifthDetailsText ?? false ? 2 : showSecondBox ?? false ? 2 : 1 : 1,
              child: Row(
                children: [
                  showFirstBox ?? false ? buildCheckOption(
                    borderColor: AppColors.t2,
                    icon: Icons.check,
                    iconColor: AppColors.t2,
                    isSelected: false,
                    onTap: (){onTapFirstBox!() ?? () {};},
                  ) : SizedBox(width: 0.w, height: 0.h,),
                  showSecondBox ?? false ? SizedBox(width: 8.w,) : SizedBox(width: 0.w, height: 0.h,),
                  showSecondBox ?? false ? buildCheckOption(
                    borderColor: AppColors.t2,
                    icon: Icons.close,
                    iconColor: AppColors.t2,
                    isSelected: false,
                    onTap: (){onTapFirstBox!() ?? () {};},
                  ) : SizedBox(width: 0.w, height: 0.h,),
                  showFirstBox ?? false ? SizedBox(width: showSecondBox ?? false ? 15.w : 10.w,) : SizedBox(width: 0.w, height: 0.h,),
                  //image
                  image != null ? CustomImageNetwork(
                    imageWidth: imageWidth ?? 24.w,
                    imageHeight: imageHeight ?? 24.w,
                    borderRadius: imageBorderRadius ?? 30.r,
                    image: image,
                  ) : CustomImageAsset(
                    imageWidth: imageWidth ?? 24.w,
                    imageHeight: imageHeight ?? 24.w,
                    borderRadius: imageBorderRadius ?? 30.r,
                  ),
                  //Information
                  SizedBox(width: widthProfileText ?? 8.12.w,),
                  Expanded(
                    child: Text(
                      name,
                      style: Styles.l2Medium(color: nameColor ?? AppColors.t3),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            showSecondDetailsText ?? false ? SizedBox(width: 80.w,) : SizedBox(width: 0.w, height: 0.h,),
            showSecondDetailsText ?? false ? Expanded(
              flex: 1,
              child: Text(
                secondText ?? '',
                style: Styles.l2Medium(color: secondTextColor ?? AppColors.t3),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ) : SizedBox(width: 0.w, height: 0.h,),
            SizedBox(width: 50.w,),
            Expanded(
              flex: showJustTowDetailsText ?? false ? 3 : 2,
              child: Text(
                thirdDetailsText ?? '',
                style: Styles.l2Medium(color: thirdDetailsTextColor ?? AppColors.t3),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 50.w,),
            Expanded(
              flex: 1,
              child: Text(
                fourthDetailsText ?? '',
                style: Styles.l2Medium(color: fourthDetailsTextColor ?? AppColors.t3),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            showFifthDetailsText ?? false ? SizedBox(width: 50.w,) : SizedBox(width: 0.w, height: 0.h,),
            showFifthDetailsText ?? false ? Expanded(
              flex: 1,
              child: Text(
                fifthText ?? 'Complete',
                style: Styles.l2Medium(color: fifthTextColor ?? AppColors.mintGreen),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ) : SizedBox(width: 0.w, height: 0.h,),
            //Action icons
            SizedBox(width: 50.0.h,),
            showIcons ?? false ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                hideFirstIcon ?? false ? SizedBox(width: 25.w, height: 0.h,) : CustomIconButton(icon: leftIcon ?? Icons.edit_outlined, onTap: (){onTapFirstIcon();},),
                SizedBox(width: 10.8.w,),
                hideSecondIcon ?? false ? SizedBox(width: 25.w, height: 0.h,) : CustomIconButton(icon: rightIcon ?? Icons.delete_outline, onTap: (){onTapSecondIcon();},),
              ],
            ) : SizedBox(width: 0, height: 0,),
            showIcons ?? false ? SizedBox(width: 0.w,) : SizedBox(width: showFifthDetailsText ?? false ? 0.w : 70.w),
          ],
        ),
      ),
    );
  }
}

Widget buildCheckOption({
  required bool isSelected,
  required IconData icon,
  required Color borderColor,
  required Color iconColor,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: 25.r,
      height: 25.r,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1.w),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Icon(icon, size: 16.0, color: isSelected ? AppColors.mintGreen : iconColor),
    ),
  );
}