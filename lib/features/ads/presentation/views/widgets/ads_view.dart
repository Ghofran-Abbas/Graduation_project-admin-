import 'package:admin_alhadara_dashboard/features/ads/presentation/views/widgets/ads_body.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../../../core/widgets/secretary/side_bar.dart';

import '../../manager/getAllAdsCubit/add-delete_cubit.dart';
import '../../manager/getAllAdsCubit/getAllAdsCubit.dart';
//
//
// class AnnouncementsView extends StatelessWidget {
//   const AnnouncementsView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     context.read<AdsCubit>().fetchAds(page: 1);
//
//     return const AnnouncementsViewBody();
//   }
// }
//









import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/getAllAdsCubit/add-delete_state.dart';
import '../../manager/getAllAdsCubit/getAllAdsCubit.dart';


class AnnouncementsView extends StatelessWidget {
  const AnnouncementsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // initial load
    context.read<AdsCubit>().fetchAds(page: 1);

    // Provide DeleteAdCubit once for whole subtree and listen to its results
    return BlocProvider<DeleteAdCubit>(
      create: (_) => getIt<DeleteAdCubit>(),
      child: BlocListener<DeleteAdCubit, DeleteAdState>(
        listener: (ctx, state) {
          if (state is DeleteAdSuccess) {
            // show success message then reload ads
            ScaffoldMessenger.of(ctx).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            // reload first page (or current page if you track it)
            context.read<AdsCubit>().fetchAds(page: 1);
          } else if (state is DeleteAdFailure) {
            ScaffoldMessenger.of(ctx).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.redAccent),
            );
          }
        },
        child: const AnnouncementsViewBody(),
      ),
    );
  }
}
