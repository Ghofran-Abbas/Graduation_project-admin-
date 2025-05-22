import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../data/repos/verification_repo_impl.dart';
import '../manager/verification_cubit/verification_cubit.dart';
import 'widgets/verification_view_body.dart';

class VerificationView extends StatelessWidget {
  const VerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return VerificationCubit(
          getIt.get<VerificationRepoImpl>(),
        );
      },
      child: Scaffold(body: VerificationViewBody()),
    );
  }
}
