// lib/features/gifts/presentation/manager/gifts_cubit/gifts_state.dart

import '../../../data/models/gift_model.dart';

abstract class GiftsState {}

/// Before any fetch
class GiftsInitial extends GiftsState {}

/// While loading
class GiftsLoading extends GiftsState {}

/// On any successful page load
class GiftsSuccess extends GiftsState {
  final List<Gift> gifts;
  final int currentPage;
  final int lastPage;

  GiftsSuccess({
    required this.gifts,
    required this.currentPage,
    required this.lastPage,
  });
}

/// On error
class GiftsFailure extends GiftsState {
  final String error;
  GiftsFailure(this.error);
}
