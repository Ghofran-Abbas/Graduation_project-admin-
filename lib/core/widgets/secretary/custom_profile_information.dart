import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/widgets/custom_image_network.dart';
import '../../../../../../core/widgets/secretary/custom_information_field.dart';
import '../../localization/app_localizations.dart';
import '../../utils/app_colors.dart';
import '../../utils/styles.dart';
import '../custom_icon_button.dart';
import 'custom_about.dart';
import 'custom_icon_box_information.dart';
import 'custom_overloading_avatar.dart';

class CustomProfileInformation extends StatelessWidget {
  const CustomProfileInformation({super.key, this.image, this.imageWidth, this.imageHeight, this.borderRadius, required this.name, this.detailsText, this.showDetailsText, required this.firstBoxText, required this.firstBoxIcon, required this.secondBoxText, required this.secondBoxIcon, this.aboutText, this.showAboutText, this.firstFieldInfoTitle, required this.firstFieldInfoText, this.secondFieldInfoTitle, required this.secondFieldInfoText, this.thirdFieldInfoTitle, this.thirdFieldInfoText, this.showThirdFieldInfo, this.showThirdFieldInfoIcon, required this.labelText, this.firstImage, this.secondImage, this.thirdImage, this.fourthImage, this.fifthImage, required this.tailText, this.showOverloadingAvatar, required this.avatarCount, required this.onTap});

  final String? image;
  final double? imageWidth;
  final double? imageHeight;
  final double? borderRadius;
  final String name;
  final String? detailsText;
  final bool? showDetailsText;
  final String firstBoxText;
  final IconData firstBoxIcon;
  final String secondBoxText;
  final IconData secondBoxIcon;
  final String? aboutText;
  final bool? showAboutText;
  final String? firstFieldInfoTitle;
  final String firstFieldInfoText;
  final String? secondFieldInfoTitle;
  final String secondFieldInfoText;
  final String? thirdFieldInfoTitle;
  final String? thirdFieldInfoText;
  final bool? showThirdFieldInfo;
  final bool? showThirdFieldInfoIcon;
  final String labelText;
  final String? firstImage;
  final String? secondImage;
  final String? thirdImage;
  final String? fourthImage;
  final String? fifthImage;
  final String tailText;
  final int avatarCount;
  final bool? showOverloadingAvatar;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h, bottom: 20.h, left: 118.w, right: 50.w,),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              image != null ? CustomImageNetwork(
                image: image,
                imageWidth: imageWidth ?? 252.w,
                imageHeight: imageHeight ?? 252.w,
                borderRadius: borderRadius ?? 210.r,
              ) : CustomImageAsset(
                imageWidth: imageWidth ?? 252.w,
                imageHeight: imageHeight ?? 252.w,
                borderRadius: borderRadius ?? 210.r,
              ),
              SizedBox(height: 65.h,),
              Text(
                name,
                style: Styles.b2Bold(color: AppColors.t4),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: showDetailsText ?? false ? 5.h : 0.h,),
              showDetailsText ?? false ? Text(
                detailsText ?? '',
                style: Styles.l1Bold(color: AppColors.t1),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ) : SizedBox(width: 0.w, height: 0.h,),
              SizedBox(height: showDetailsText ?? false ? 45.h : 79.h,),
              Row(
                children: [
                  CustomIconBoxInformation(
                    toolTipText: firstBoxText,
                    icon: firstBoxIcon,
                  ),
                  SizedBox(width: 22.w,),
                  CustomIconBoxInformation(
                    toolTipText: secondBoxText,
                    icon: secondBoxIcon,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: 186.w,),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              showAboutText ?? false ? SizedBox(
                width: 380.w,
                child: CustomAbout(
                  labelText: AppLocalizations.of(context).translate('About'),
                  bodyText: aboutText ?? '',
                ),
              ) : SizedBox(width: 0.w, height: 0.w,),
              //showAboutText ?? false ? SizedBox(height: 75.h) : SizedBox(width: 0.w, height: 0.w,),
              SizedBox(height: showAboutText ?? false ? 75.h : 405.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomInformationField(title: firstFieldInfoTitle ?? AppLocalizations.of(context).translate('Birth date'), textBody: firstFieldInfoText),
                  SizedBox(width: 73.w,),
                  CustomInformationField(title: secondFieldInfoTitle ?? AppLocalizations.of(context).translate('Gender'), textBody: secondFieldInfoText),
                  SizedBox(width: 73.w,),
                  showThirdFieldInfo ?? false ? CustomInformationField(title: thirdFieldInfoTitle ?? AppLocalizations.of(context).translate('Points'), textBody: thirdFieldInfoText ?? '') : SizedBox(width: 0.w, height: 0.w,),
                  showThirdFieldInfoIcon ?? false ? SizedBox(width: 15.w,) : SizedBox(width: 0.w, height: 0.w,),
                  showThirdFieldInfoIcon ?? false ? CustomIconButton(
                    icon: Icons.edit,
                    onTap: (){onTap();},
                  ) : SizedBox(width: 0.w, height: 0.w,),
                ],
              ),
              SizedBox(height: 52.h,),
              CustomOverloadingAvatar(
                labelText: labelText,
                firstImage: firstImage,
                secondImage: secondImage,
                thirdImage: thirdImage,
                fourthImage: fourthImage,
                fifthImage: fifthImage,
                tailText: tailText,
                avatarCount: avatarCount,
                onTap: (){},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomDetailsInformation extends StatelessWidget {
  const CustomDetailsInformation({super.key, this.image, this.imageWidth, this.imageHeight, this.borderRadius, this.name, this.detailsText, this.showFileTapText, this.aboutText, this.showAboutText, required this.onTap, this.showDetailsText, this.isAnnouncement, this.startDate, this.endDate});

  final String? image;
  final double? imageWidth;
  final double? imageHeight;
  final double? borderRadius;
  final String? name;
  final bool? showFileTapText;
  final String? detailsText;
  final bool? showDetailsText;
  final String? aboutText;
  final bool? showAboutText;
  final Function onTap;
  final bool? isAnnouncement;
  final String? startDate;
  final String? endDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0.h, bottom: 20.h, left: 108.w, right: 50.w,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              image != null ? CustomImageNetwork(
                image: image,
                imageWidth: imageWidth ?? 252.w,
                imageHeight: imageHeight ?? 252.w,
                borderRadius: borderRadius ?? 210.r,
              ) : CustomImageAsset(
                imageWidth: imageWidth ?? 252.w,
                imageHeight: imageHeight ?? 252.w,
                borderRadius: borderRadius ?? 210.r,
              ),
              SizedBox(width: 45.w,),
              Padding(
                padding: EdgeInsets.only(top: 108.h, left: 20.w),
                child: isAnnouncement ?? false ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.rocket_launch_outlined,
                          color: AppColors.darkLightPurple,
                          size: 45.r,
                        ),
                        SizedBox(width: 15.w,),
                        Text(
                          startDate ?? '',
                          style: Styles.h3Bold(color: AppColors.t0),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      children: [
                        Icon(
                          Icons.rocket_launch_outlined,
                          color: AppColors.darkLightPurple,
                          size: 45.r,
                        ),
                        SizedBox(width: 15.w,),
                        Text(
                          endDate ?? '',
                          style: Styles.h3Bold(color: AppColors.t0),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ) : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 2.w, bottom: 22.h),
                      child: Text(
                        name ?? '',
                        style: Styles.b2Bold(color: AppColors.t4),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: showFileTapText ?? false ? 5.h : 0.h,),
                    showFileTapText ?? false ? GestureDetector(
                      child: Row(
                        children: [
                          Icon(
                            Icons.file_copy_outlined,
                            color: AppColors.darkLightPurple,
                            size: 35.r,
                          ),
                          SizedBox(width: 4.w,),
                          Text(
                            detailsText ?? 'Tab to download',
                            style: Styles.l2Medium(color: AppColors.t0),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      onTap: () {onTap();},
                    ) : SizedBox(width: 0.w, height: 0.h,),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 46.h,),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              showDetailsText ?? false ? Text(
                detailsText ?? '',
                style: Styles.h3Bold(color: AppColors.t4),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ) : SizedBox(width: 0.w, height: 0.h,),
              SizedBox(height: showDetailsText ?? false ? 35.h : 0.h),
              showAboutText ?? false ? SizedBox(
                width: 880.w,
                height: 680.h,
                child: CustomAbout(
                  labelText: AppLocalizations.of(context).translate('Description'),
                  bodyText: aboutText ?? '',
                  bigText: true,
                  maxLines: 14 ,
                  width: 938.w,
                  height: 978.h,
                  horizontal: 120.w,
                  vertical: 135.h,
                ),
              ) : SizedBox(width: 0.w, height: 0.w,),
              SizedBox(height: showAboutText ?? false ? 75.h : 405.h),
            ],
          ),
        ],
      ),
    );
  }
}
