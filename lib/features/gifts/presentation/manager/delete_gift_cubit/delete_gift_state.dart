// lib/features/gifts/presentation/manager/delete_gift_cubit/delete_gift_state.dart

abstract class DeleteGiftState {
  const DeleteGiftState();
}
class DeleteGiftInitial extends DeleteGiftState {
  const DeleteGiftInitial();
}
class DeleteGiftLoading extends DeleteGiftState {
  const DeleteGiftLoading();
}
class DeleteGiftSuccess extends DeleteGiftState {
  const DeleteGiftSuccess();
}
class DeleteGiftFailure extends DeleteGiftState {
  final String error;
  const DeleteGiftFailure(this.error);
}
