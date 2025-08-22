// lib/features/ads/presentation/views/update_announcement_view.dart

import 'package:admin_alhadara_dashboard/features/ads/presentation/views/widgets/updateDetail_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/ad_detail_model.dart';
import '../../../data/models/ad_model.dart';
import '../../manager/getAllAdsCubit/updateAd_cubit.dart';
import '../../manager/getAllAdsCubit/updateAd_state.dart';


class UpdateAnnouncementView extends StatelessWidget {
  final AdModel ad;
  const UpdateAnnouncementView({Key? key, required this.ad,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: BlocListener<UpdateAdCubit, UpdateAdState>(
          listener: (ctx, state) {
            if (state is UpdateAdSuccess) {
              ScaffoldMessenger.of(ctx).showSnackBar(
                const SnackBar(content: Text('Announcement updated')),
              );
              Navigator.of(ctx).pop(true);
            } else if (state is UpdateAdFailure) {
              ScaffoldMessenger.of(ctx).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
          },
          child: UpdateAnnouncementBody(ad: ad),
        ),
      ),
    );
  }
}