import 'package:equatable/equatable.dart';
import '../../../data/models/section_ratings_model.dart';

abstract class SectionRatingsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SectionRatingsInitial extends SectionRatingsState {}

class SectionRatingsLoading extends SectionRatingsState {}

class SectionRatingsFailure extends SectionRatingsState {
  final String error;
  SectionRatingsFailure(this.error);
  @override
  List<Object?> get props => [error];
}

class SectionRatingsSuccess extends SectionRatingsState {
  final List<SectionRatingStat> items;

  // Echo back the filters used
  final String? startDate;
  final String? endDate;
  final int?    limit;
  final String? order;

  SectionRatingsSuccess({
    required this.items,
    this.startDate,
    this.endDate,
    this.limit,
    this.order,
  });

  @override
  List<Object?> get props => [items, startDate, endDate, limit, order];
}
