// lib/features/ads/presentation/manager/single_ad_cubit/single_ad_state.dart

import '../../../data/models/ad_detail_model.dart';

abstract class SingleAdState {}

class SingleAdInitial extends SingleAdState {}
class SingleAdLoading extends SingleAdState {}
class SingleAdLoaded  extends SingleAdState {
  final AdDetailModel ad;
  SingleAdLoaded(this.ad);
}
class SingleAdError   extends SingleAdState {
  final String message;
  SingleAdError(this.message);
}
