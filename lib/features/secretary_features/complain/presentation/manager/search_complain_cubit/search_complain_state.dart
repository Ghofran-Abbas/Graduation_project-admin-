import 'package:equatable/equatable.dart';

import '../../../data/models/search_complain_model.dart';

abstract class SearchComplainState extends Equatable{
  const SearchComplainState();

  @override
  List<Object?> get props => [];
}

class SearchComplainInitial extends SearchComplainState{}
class SearchComplainLoading extends SearchComplainState{}
class SearchComplainFailure extends SearchComplainState{
  final String errorMessage;

  const SearchComplainFailure(this.errorMessage);
}
class SearchComplainSuccess extends SearchComplainState{
  final SearchComplainModel complain;

  const SearchComplainSuccess(this.complain);
}