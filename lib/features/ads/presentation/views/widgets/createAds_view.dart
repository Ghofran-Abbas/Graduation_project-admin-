// lib/features/ads/presentation/views/create_announcement_view.dart

import 'package:admin_alhadara_dashboard/features/ads/presentation/views/widgets/createAds_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../manager/getAllAdsCubit/addAd_state.dart';
import '../../manager/getAllAdsCubit/addAdd_cubit.dart';
import '../../manager/getAllAdsCubit/getAllAdsCubit.dart';


class CreateAnnouncementView extends StatelessWidget {
  const CreateAnnouncementView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: BlocListener<CreateAdCubit, CreateAdState>(
          listener: (ctx, state) {
            if (state is CreateAdSuccess) {
              Navigator.of(ctx).pop(true);
              ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(content: Text('تمّ إنشاء الإعلان')));
            } else if (state is CreateAdFailure) {
              ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(state.error), backgroundColor: Colors.redAccent));
            }
          },
          child: CreateAnnouncementBody(),
        ),
      ),
    );
  }
}
