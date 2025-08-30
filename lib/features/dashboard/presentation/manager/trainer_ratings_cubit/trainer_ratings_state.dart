import 'package:equatable/equatable.dart';
import '../../../data/models/trainer_ratings_model.dart';

abstract class TrainerRatingsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TrainerRatingsInitial extends TrainerRatingsState {}
class TrainerRatingsLoading extends TrainerRatingsState {}

class TrainerRatingsFailure extends TrainerRatingsState {
  final String error;
  TrainerRatingsFailure(this.error);
  @override
  List<Object?> get props => [error];
}

class TrainerRatingsSuccess extends TrainerRatingsState {
  final List<TrainerRatingStat> items;
  final String? startDate;
  final String? endDate;
  final int?    limit;
  final String? order;

  TrainerRatingsSuccess({
    required this.items,
    this.startDate,
    this.endDate,
    this.limit,
    this.order,
  });

  @override
  List<Object?> get props => [items, startDate, endDate, limit, order];
}
