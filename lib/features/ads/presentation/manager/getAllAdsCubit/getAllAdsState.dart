// lib/features/ads/presentation/manager/getAllAdsCubit/ads_state.dart

import 'package:equatable/equatable.dart';
import '../../../data/models/ads_page_model.dart';

abstract class AdsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdsInitial extends AdsState {}

class AdsLoading extends AdsState {}

class AdsLoaded extends AdsState {
  final AdsPage page;
  AdsLoaded(this.page);

  @override
  List<Object?> get props => [page];
}

class AdsError extends AdsState {
  final String message;
  AdsError(this.message);

  @override
  List<Object?> get props => [message];
}
