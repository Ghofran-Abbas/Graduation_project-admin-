// lib/features/ads/presentation/manager/create_ad_cubit/create_ad_state.dart

import '../../../data/models/ad_detail_model.dart';

abstract class CreateAdState {}

class CreateAdInitial extends CreateAdState {}
class CreateAdLoading extends CreateAdState {}
class CreateAdSuccess extends CreateAdState {
  final AdDetailModel ad;
  CreateAdSuccess(this.ad);

}
class CreateAdFailure extends CreateAdState {
  final String error;
  CreateAdFailure(this.error);
}
