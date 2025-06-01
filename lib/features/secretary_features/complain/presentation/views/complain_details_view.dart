import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../report/data/repos/report_repo_impl.dart';
import '../../../report/presentation/manager/get_file_cubit/get_file_cubit.dart';
import '../../data/repos/complain_repo_impl.dart';
import '../manager/details_complain_cubit/details_complain_cubit.dart';
import 'widgets/complain_details_view_body.dart';

class ComplainDetailsView extends StatelessWidget {
  const ComplainDetailsView({super.key, required this.complainId});

  final int complainId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return DetailsComplainCubit(
              getIt.get<ComplainRepoImpl>(),
            )..fetchDetailsComplain(id: complainId);
          },
        ),
        BlocProvider(
          create: (context) {
            return GetFileCubit(
              getIt.get<ReportRepoImpl>(),
            );
          },
        ),
      ],
      child: ComplainDetailsViewBody(),
    );
  }
}
