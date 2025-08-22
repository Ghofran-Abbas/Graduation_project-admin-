import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/go_router_path.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../../core/widgets/secretary/custom_label_text_form_field.dart';
import '../../../../../core/widgets/text_icon_button.dart';
import '../../manager/login_cubit/login_secretary_cubit.dart';
import '../../manager/login_cubit/login_secretary_state.dart';

class LoginViewBody extends StatelessWidget {
  Future<String> _getDeviceToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    return token ?? 'unknown_token';
  }

  LoginViewBody({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('LoginFailure'),);
          } else if(state is LoginSuccess) {
            emailController.clear();
            passwordController.clear();
            context.go(GoRouterPath.dashboard);
            CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('LoginSuccess'),);
          }
        },
        builder: (context, state) {
          LoginCubit cubit = BlocProvider.of(context);
          return Form(
            key: _formKey,
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: [
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Container(
                      width: 300.w,
                      height: 260.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(130.r)),
                        color: AppColors.purple,
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h,),
                  Row(
                    children: [
                      Container(
                        width: 700.w,
                        height: 400.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(Assets.login),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            CustomLabelTextFormField(
                              labelText: AppLocalizations.of(context).translate('Email address'),
                              showLabelText: true,
                              controller: emailController,
                              topPadding: 20.h,
                              bottomPadding: 0.h,
                              leftPadding: 175.w,
                              rightPadding: 127.w,
                              validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('This field required') : null,
                            ),
                            CustomLabelTextFormField(
                              labelText: AppLocalizations.of(context).translate('Password'),
                              showLabelText: true,
                              controller: passwordController,
                              topPadding: 42.h,
                              bottomPadding: 0.h,
                              leftPadding: 175.w,
                              rightPadding: 127.w,
                              validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('This field required') : null,
                            ),
                            SizedBox(height: 100.h,),
                            TextIconButton(
                              textButton: AppLocalizations.of(context).translate('Log in'),
                              bigText: true,
                              textColor: AppColors.white,
                              showButtonIcon: false,
                              iconLast: false,
                              firstSpaceBetween: 3.w,
                              buttonHeight: 53.h,
                              borderWidth: 0.w,
                              buttonColor: AppColors.purple,
                              borderColor: Colors.transparent,
                              onPressed: ()async{
                                String deviceKey = await _getDeviceToken();
                                print("🔑 deviceKey=$deviceKey");
                                if(_formKey.currentState!.validate()) {
                                  cubit.fetchCreateTrainer(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    fcm_token: deviceKey,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h,),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Container(
                      width: 300.w,
                      height: 260.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(130.r)),
                        color: AppColors.purple,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}