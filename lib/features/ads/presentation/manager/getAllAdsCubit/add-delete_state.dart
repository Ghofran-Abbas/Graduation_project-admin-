// lib/features/ads/presentation/manager/delete_ad_cubit/delete_ad_state.dart

abstract class DeleteAdState {}

class DeleteAdInitial extends DeleteAdState {}
class DeleteAdLoading extends DeleteAdState {}
class DeleteAdSuccess extends DeleteAdState {
  final String message;
  DeleteAdSuccess(this.message);
}
class DeleteAdFailure extends DeleteAdState {
  final String error;
  DeleteAdFailure(this.error);
}
