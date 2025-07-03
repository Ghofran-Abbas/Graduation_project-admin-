// lib/features/gifts/presentation/manager/create_gift_cubit/create_gift_state.dart

import '../../../data/models/gift_model.dart';

abstract class CreateGiftState {
  const CreateGiftState();
}
class CreateGiftInitial extends CreateGiftState {
  const CreateGiftInitial();
}
class CreateGiftLoading extends CreateGiftState {
  const CreateGiftLoading();
}
class CreateGiftSuccess extends CreateGiftState {
  final Gift gift;
  const CreateGiftSuccess(this.gift);
}
class CreateGiftFailure extends CreateGiftState {
  final String error;
  const CreateGiftFailure(this.error);
}
