// lib/features/ads/data/models/ads_page_model.dart

import 'ad_model.dart';

class AdsPage {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final List<AdModel> ads;

  AdsPage({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.ads,
  });

  factory AdsPage.fromJson(Map<String, dynamic> json) {
    final d = json['data'] as Map<String, dynamic>;
    final list = (d['data'] as List)
        .map((e) => AdModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return AdsPage(
      currentPage: d['current_page'] as int,
      lastPage:    d['last_page']    as int,
      perPage:     d['per_page']     as int,
      total:       d['total']        as int,
      ads:         list,
    );
  }
}
