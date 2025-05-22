import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../data/repos/complain_repo_impl.dart';
import '../manager/delete_complain_cubit/delete_complain_cubit.dart';
import '../manager/search_complain_cubit/search_complain_cubit.dart';
import 'widgets/search_complain_view_body.dart';

class SearchComplainView extends StatelessWidget {
  const SearchComplainView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return SearchComplainCubit(
              getIt.get<ComplainRepoImpl>(),
            );
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
      child: SearchComplainViewBody(),
    );
  }
}
