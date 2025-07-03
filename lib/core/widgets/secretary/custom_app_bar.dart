import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../features/profile/presentaion/views/widgets/profile_view_body.dart';
import '../../localization/app_localizations.dart';
import '../../localization/local_cubit/local_cubit.dart';
import '../../utils/app_colors.dart';
import '../../utils/go_router_path.dart';
import '../../utils/styles.dart';
import '../custom_circular_progress_indicator.dart';
import '../custom_image_network.dart';
import '../custom_text_form_field.dart';
import '../custom_text_info.dart';
import '../text_icon_button.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.showSearchField,
    this.textFirstButton,
    this.showFirstButton,
    this.showButtonIcon,
    this.textSecondButton,
    this.showSecondButton,
    this.showThirdButton,
    this.textThirdButton,
    required this.onPressedFirst,
    required this.onPressedSecond,
    this.onPressedThird,
    this.widget,
    this.turnSearch,
    this.onFieldSubmitted,
    this.searchController,
    this.onTapSearch,
    this.showProfileAvatar,
  });

  final String title;
  final bool? showProfileAvatar;
  final bool? showSearchField;
  final String? textFirstButton;
  final bool? showFirstButton;
  final bool? showButtonIcon;
  final String? textSecondButton;
  final bool? showSecondButton;
  final String? textThirdButton;
  final bool? showThirdButton;
  final Function onPressedFirst;
  final Function onPressedSecond;
  final Function? onPressedThird;
  final bool? turnSearch;
  final Function? onTapSearch;
  final Function? onFieldSubmitted;
  final TextEditingController? searchController;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top title & translate icon row
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: Styles.h2Bold(color: AppColors.blue)),
              GestureDetector(
                child: Icon(
                  Icons.translate_outlined,
                  color: AppColors.darkLightPurple,
                  size: 34.r,
                ),
                onTap: () {
                  final localeCubit = BlocProvider.of<LocaleCubit>(context);
                  if (localeCubit.state.languageCode == 'en') {
                    localeCubit.toArabic();
                  } else {
                    localeCubit.toEnglish();
                  }
                },
              ),
            ],
          ),
        ),

        SizedBox(height: 47.h),

        // Search field & buttons row
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Optional placeholder search info
              if (showSearchField ?? false)
                GestureDetector(
                  onTap: () => onTapSearch?.call(),
                  child: CustomTextInfo(
                    textAddress: loc.translate('Search here...'),
                    text: '',
                    width: 199.96.w,
                    height: 53.h,
                    borderRadius: 24.67,
                    borderColor: Colors.transparent,
                    color: AppColors.highlightPurple,
                  ),
                ),

              // Actual text field when in search mode
              if (turnSearch ?? false)
                Flexible(
                  child: SizedBox(
                    width: 1108.96.w,
                    height: 53.h,
                    child: CustomTextFormField(
                      hintText: loc.translate('Search here...'),
                      hintTextStyle: Styles.l2Medium(color: AppColors.t1),
                      borderRadius: 4.r,
                      borderColor: Colors.transparent,
                      contentPadding: EdgeInsets.symmetric(horizontal: 19.73.w),
                      filled: true,
                      fillColor: AppColors.highlightPurple,
                      prefixIcon: Icons.search_outlined,
                      prefixSize: 19.73.r,
                      controller: searchController,
                      onTap: () {},
                      onPressed: () {},
                      onFieldSubmitted:
                          (value) => onFieldSubmitted?.call(value),
                    ),
                  ),
                ),

              // Buttons
              Row(
                children: [
                  // Third button (Most Points Secretary)
                  if (showThirdButton ?? false) ...[
                    TextIconButton(
                      textButton:
                          textThirdButton ??
                          loc.translate('Most Points Secretary'),
                      buttonHeight: 53.h,
                      buttonColor: AppColors.white,
                      borderRadius: 24.67,
                      iconLast: false,
                      textColor: AppColors.purple,
                      showButtonIcon: true,
                      onPressed: () => onPressedThird?.call(),
                    ),
                    SizedBox(width: 14.w),
                  ],

                  // First button (e.g. dropdown or custom widget)
                  if (showFirstButton ?? false) ...[
                    widget ??
                        TextIconButton(
                          textButton: textFirstButton ?? '',
                          textColor: AppColors.purple,
                          buttonHeight: 53.h,
                          icon: Icons.keyboard_arrow_down,
                          iconSize: 30.01.r,
                          iconColor: AppColors.purple,
                          borderRadius: 24.67,
                          buttonColor: AppColors.white,
                          iconLast: true,
                          showButtonIcon: showButtonIcon,
                          onPressed: () => onPressedFirst(),
                        ),
                    SizedBox(width: 14.w),
                  ],

                  // Second button (Add / New)
                  if (showSecondButton ?? false)
                    TextIconButton(
                      textButton: textSecondButton ?? '',
                      buttonHeight: 53.h,
                      icon: Icons.add,
                      iconSize: 30.01.r,
                      borderRadius: 24.67,
                      iconLast: false,
                      showButtonIcon: showButtonIcon,
                      onPressed: () => onPressedSecond(),
                    ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 171.h),
      ],
    );
  }
}
