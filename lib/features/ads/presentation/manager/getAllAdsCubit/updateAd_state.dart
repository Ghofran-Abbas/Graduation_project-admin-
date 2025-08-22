// lib/features/ads/presentation/manager/update_ad_cubit/update_ad_state.dart

import '../../../data/models/ad_detail_model.dart';

abstract class UpdateAdState {}

class UpdateAdInitial extends UpdateAdState {}
class UpdateAdLoading extends UpdateAdState {}
class UpdateAdSuccess extends UpdateAdState {
  final AdDetailModel ad;
  UpdateAdSuccess(this.ad);
}
class UpdateAdFailure extends UpdateAdState {
  final String error;
  UpdateAdFailure(this.error);
}
