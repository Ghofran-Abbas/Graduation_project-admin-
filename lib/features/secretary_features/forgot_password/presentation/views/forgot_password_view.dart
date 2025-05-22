import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../data/repos/forgot_password_repo_impl.dart';
import '../manager/forgot_password_cubit/forgot_password_cubit.dart';
import 'widgets/forgot_password_view_body.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ForgotPasswordCubit(
          getIt.get<ForgotPasswordRepoImpl>(),
        );
      },
      child: Scaffold(body: ForgotPasswordViewBody()),
    );
  }
}
