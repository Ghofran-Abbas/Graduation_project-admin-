import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../data/repos/complain_repo_impl.dart';
import '../manager/details_complain_cubit/details_complain_cubit.dart';
import 'widgets/complain_details_view_body.dart';

class ComplainDetailsView extends StatelessWidget {
  const ComplainDetailsView({super.key, required this.complainId});

  final int complainId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return DetailsComplainCubit(
          getIt.get<ComplainRepoImpl>(),
        )..fetchDetailsComplain(id: complainId);
      },
      child: ComplainDetailsViewBody(),
    );
  }
}
