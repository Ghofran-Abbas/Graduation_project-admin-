// lib/features/ads/presentation/manager/active_ads_cubit/active_ads_state.dart

import '../../../data/models/ads_page_model.dart';

abstract class ActiveAdsState {}

class ActiveAdsInitial extends ActiveAdsState {}

class ActiveAdsLoading extends ActiveAdsState {}

class ActiveAdsLoaded extends ActiveAdsState {
  final AdsPage page;
  ActiveAdsLoaded(this.page);
}

class ActiveAdsError extends ActiveAdsState {
  final String message;
  ActiveAdsError(this.message);
}
