import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/task_model.dart';
import '../../../data/repos/task_repo.dart';
import 'tasks_state.dart';

/// Admin list with pagination
class TasksCubit extends Cubit<TasksState> {
  final TaskRepo _repo;

  final List<Task> _all = [];
  int _currentPage = 0;
  int _lastPage = 1;
  bool _loadingMore = false;

  TasksCubit(this._repo) : super(TasksInitial());

  Future<void> fetchFirstPage() async {
    emit(TasksLoading());
    _all.clear();
    _currentPage = 0;
    try {
      final page = await _repo.fetchAllForAdmin(page: 1);
      _all.addAll(page.data);
      _currentPage = page.currentPage;
      _lastPage = page.lastPage;
      emit(TasksSuccess(List.from(_all), hasMore: _currentPage < _lastPage));
    } catch (e) {
      emit(TasksFailure(e.toString()));
    }
  }

  Future<void> fetchNextPage() async {
    if (_loadingMore || _currentPage >= _lastPage) return;
    _loadingMore = true;
    try {
      final page = await _repo.fetchAllForAdmin(page: _currentPage + 1);
      _all.addAll(page.data);
      _currentPage = page.currentPage;
      emit(TasksSuccess(List.from(_all), hasMore: _currentPage < _lastPage));
    } finally {
      _loadingMore = false;
    }
  }
}
