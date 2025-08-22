// lib/features/ads/data/repos/delete_ad_repository.dart

abstract class DeleteAdRepository {
  /// Deletes an ad by id and returns the server message
  Future<String> deleteAd(int id);
}
