import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../data/repos/complain_repo_impl.dart';
import '../manager/complains_cubit/complains_cubit.dart';
import '../manager/delete_complain_cubit/delete_complain_cubit.dart';
import 'widgets/complains_view_body.dart';

class ComplainsView extends StatelessWidget {
  const ComplainsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return ComplainsCubit(
              getIt.get<ComplainRepoImpl>(),
            )..fetchComplains(page: 1);
          },
        ),
        BlocProvider(
          create: (context) {
            return DeleteComplainCubit(
              getIt.get<ComplainRepoImpl>(),
            );
          },
        ),
      ],
      child: const ComplainsViewBody(),
    );
  }
}
