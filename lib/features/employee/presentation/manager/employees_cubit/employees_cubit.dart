// lib/features/employee/manager/employees_cubit.dart

import 'package:bloc/bloc.dart';
import '../../../data/models/employees_model.dart';
import '../../../data/repos/employee_repo.dart';
import 'employees_state.dart';

class EmployeesCubit extends Cubit<EmployeesState> {
  final EmployeeRepo _repo;

  // Internal list & pagination tracking
  final List<Employee> _allEmployees = [];
  int _currentPage = 0;
  int _lastPage = 1;
  bool _isLoadingMore = false;

  EmployeesCubit(this._repo) : super(EmployeesInitial());

  /// Load the first page (or refresh)
  Future<void> fetchFirstPage() async {
    emit(EmployeesLoading());
    _allEmployees.clear();
    _currentPage = 0;
    try {
      final page = await _repo.fetchAll(page: 1);
      _allEmployees.addAll(page.data);
      _currentPage = page.currentPage;
      _lastPage = page.lastPage;
      emit(EmployeesSuccess(
        List.from(_allEmployees),
        hasMore: _currentPage < _lastPage,
      ));
    } catch (e) {
      emit(EmployeesFailure(e.toString()));
    }
  }

  /// Load the next page when scrolling
  Future<void> fetchNextPage() async {
    if (_isLoadingMore || _currentPage >= _lastPage) return;
    _isLoadingMore = true;
    try {
      final page = await _repo.fetchAll(page: _currentPage + 1);
      _allEmployees.addAll(page.data);
      _currentPage = page.currentPage;
      emit(EmployeesSuccess(
        List.from(_allEmployees),
        hasMore: _currentPage < _lastPage,
      ));
    } catch (e) {
      // Optionally: emit a separate state for load-more errors
    } finally {
      _isLoadingMore = false;
    }
  }
}
