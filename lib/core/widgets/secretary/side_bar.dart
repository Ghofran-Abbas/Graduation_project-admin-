import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../features/secretary_features/logout/presentation/manager/logout_secretary_cubit/logout_secretary_cubit.dart';
import '../../../features/secretary_features/logout/presentation/manager/logout_secretary_cubit/logout_secretary_state.dart';
import '../../localization/app_localizations.dart';
import '../../utils/app_colors.dart';
import '../../utils/assets.dart';
import '../../utils/go_router_path.dart';
import '../../utils/size.dart';
import '../../utils/styles.dart';
import '../custom_snack_bar.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: BeveledRectangleBorder(),
      width: AppSize.drawerWidth,
      backgroundColor: AppColors.purple,
      child: Padding(
        padding: EdgeInsets.only(top: AppSize.drawerTopPadding),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(image: AssetImage(Assets.logo), height: 70.h,),
                    SizedBox(width: 6.w,),
                    Text(
                      'Al Hadara',
                      style: Styles.h1Bold(
                        color: AppColors.white
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40.0.h ,left: 52.0.w),
                  child: Column(
                    children: [
                      SideBarItem(name: AppLocalizations.of(context).translate('Dashboard'), icon: Icons.home_outlined, route: GoRouterPath.dashboard,),
                      SideBarItem(name: AppLocalizations.of(context).translate('Students'), icon: Icons.person_outline_outlined, route: GoRouterPath.students, color: AppColors.purple,),
                      SideBarItem(name: AppLocalizations.of(context).translate('Trainers'), icon: Icons.perm_identity, route: GoRouterPath.trainers, color: AppColors.purple,),
                      SideBarItem(name: AppLocalizations.of(context).translate('Employee'), icon: Icons.perm_identity, route: GoRouterPath.trainers, color: AppColors.purple,),
                      SideBarItem(name: AppLocalizations.of(context).translate('Announcement'), icon: Icons.announcement_outlined, route: GoRouterPath.reports, color: AppColors.purple,),
                      SideBarItem(name: AppLocalizations.of(context).translate('Reports'), icon: Icons.insert_chart, route: GoRouterPath.reports, color: AppColors.purple,),
                      SideBarItem(name: AppLocalizations.of(context).translate('Complains'), icon: Icons.mail_outlined, route: GoRouterPath.complains, color: AppColors.purple,),
                      SideBarItem(name: AppLocalizations.of(context).translate('Notification'), icon: Icons.notifications_none, route: GoRouterPath.reports, color: AppColors.purple,),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BlocConsumer<LogoutSecretaryCubit, LogoutSecretaryState>(
                  listener: (context, state) {
                    if(state is LogoutSecretarySuccess) {
                      context.go(GoRouterPath.login);
                      CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('LogoutSecretarySuccess'),);
                    } else if(state is LogoutSecretaryFailure) {
                      CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('LogoutSecretaryFailure'),);
                    }
                  },
                  builder: (context, state) {
                  return Column(
                    children: [
                      Container(
                        height: 0.5.h,
                        color: AppColors.lightPurple,
                      ),
                      GestureDetector(
                        onTap: (){
                          //context.go(GoRouterPath.login);
                          context.read<LogoutSecretaryCubit>().fetchLogoutSecretary();
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 76.0.w),
                          height: 82.h,
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.output_outlined,
                                  color: AppColors.lightPurple,
                                  size: 60.0.r,
                                ),
                                SizedBox(width: 20.0.w,),
                                Text(
                                  AppLocalizations.of(context).translate('Log out'),
                                  style: Styles.b1Normal(
                                      color: AppColors.lightPurple
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SideBarItem extends StatelessWidget {
  const SideBarItem({
    super.key, required this.name, required this.icon, required this.route, this.color,
  });

  final String name;
  final IconData icon;
  final String route;
  final Color? color;
  //final String? selectedName;

  @override
  Widget build(BuildContext context) {
    final String currentRoute = GoRouterState.of(context).uri.toString();
    final bool isSelected = currentRoute.startsWith(route);
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          context.go(route);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Container(
          height: 72.h,
          decoration: BoxDecoration(
              color: isSelected ? AppColors.white : AppColors.purple,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), bottomLeft: Radius.circular(40.0))
          ),
          padding: EdgeInsets.only(left: 24.0.w),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.purple : AppColors.lightPurple,
                size: 60.0.r,
              ),
              SizedBox(width: 20.0.w,),
              Text(
                name,
                style: Styles.b1Normal(
                    color: isSelected ? AppColors.purple : AppColors.lightPurple
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}