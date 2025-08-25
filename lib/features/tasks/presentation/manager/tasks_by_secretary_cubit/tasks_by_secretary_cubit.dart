import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/task_model.dart';
import '../../../data/repos/task_repo.dart';
import 'tasks_by_secretary_state.dart';

class TasksBySecretaryCubit extends Cubit<TasksBySecretaryState> {
  final TaskRepo _repo;
  final List<Task> _all = [];
  int _currentPage = 0;
  int _lastPage = 1;
  bool _loadingMore = false;
  int? _secId;

  TasksBySecretaryCubit(this._repo) : super(TasksBySecretaryInitial());

  Future<void> fetchFirstPage({required int secretaryId}) async {
    emit(TasksBySecretaryLoading());
    _all.clear();
    _currentPage = 0;
    _secId = secretaryId;
    try {
      final page = await _repo.fetchBySecretary(secretaryId: secretaryId, page: 1);
      _all.addAll(page.data);
      _currentPage = page.currentPage;
      _lastPage = page.lastPage;
      emit(TasksBySecretarySuccess(secretaryId, List.from(_all), hasMore: _currentPage < _lastPage));
    } catch (e) {
      emit(TasksBySecretaryFailure(e.toString()));
    }
  }

  Future<void> fetchNextPage() async {
    if (_loadingMore || _currentPage >= _lastPage || _secId == null) return;
    _loadingMore = true;
    try {
      final page = await _repo.fetchBySecretary(secretaryId: _secId!, page: _currentPage + 1);
      _all.addAll(page.data);
      _currentPage = page.currentPage;
      emit(TasksBySecretarySuccess(_secId!, List.from(_all), hasMore: _currentPage < _lastPage));
    } finally {
      _loadingMore = false;
    }
  }
}
