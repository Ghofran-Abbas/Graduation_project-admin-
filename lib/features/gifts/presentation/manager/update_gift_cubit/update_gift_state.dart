// lib/features/gifts/presentation/manager/update_gift_cubit/update_gift_state.dart

import '../../../data/models/gift_model.dart';

abstract class UpdateGiftState {}
class UpdateGiftInitial extends UpdateGiftState {}
class UpdateGiftLoading extends UpdateGiftState {}
class UpdateGiftSuccess extends UpdateGiftState {
  final Gift gift;
  UpdateGiftSuccess(this.gift);
}
class UpdateGiftFailure extends UpdateGiftState {
  final String error;
  UpdateGiftFailure(this.error);
}
