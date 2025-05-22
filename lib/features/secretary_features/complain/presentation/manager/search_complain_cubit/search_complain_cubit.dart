import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/complain_repo.dart';
import 'search_complain_state.dart';

class SearchComplainCubit extends Cubit<SearchComplainState>{
  static SearchComplainState get(context) => BlocProvider.of(context);

  final ComplainRepo complainRepo;

  SearchComplainCubit(this.complainRepo) : super(SearchComplainInitial());

  Future<void> fetchSearchComplain({required String querySearch, required int page}) async {
    emit(SearchComplainLoading());
    var result = await complainRepo.fetchSearchComplain(querySearch: querySearch, page: page);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(SearchComplainFailure(failure.errorMessage));
    }, (complain) {
      emit(SearchComplainSuccess(complain));
    });
  }
}