// lib/features/ads/presentation/views/announcement_details_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';

import '../../manager/getAllAdsCubit/singleAdCubit.dart';
import '../../manager/getAllAdsCubit/updateAd_cubit.dart';
import '../../manager/getAllAdsCubit/updateAd_state.dart';
import 'adsDetail_body.dart';


class AnnouncementDetailsView extends StatelessWidget {
  final int adId;
  const AnnouncementDetailsView({Key? key, required this.adId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SingleAdCubit>(
      create: (_) => getIt<SingleAdCubit>()..fetchAd(adId),
      child: const AnnouncementDetailsBody(),
    );
  }
}

