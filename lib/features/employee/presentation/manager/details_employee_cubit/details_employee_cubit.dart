import 'package:bloc/bloc.dart';
import '../../../data/repos/employee_repo.dart';
import 'details_employee_state.dart';

class DetailsEmployeeCubit extends Cubit<DetailsEmployeeState> {
  final EmployeeRepo _repo;
  DetailsEmployeeCubit(this._repo) : super(DetailsEmployeeInitial());

  Future<void> fetchEmployee(int id) async {
    try {
      emit(DetailsEmployeeLoading());
      final emp = await _repo.fetchById(id);
      emit(DetailsEmployeeSuccess(emp));
    } catch (e) {
      emit(DetailsEmployeeFailure(e.toString()));
    }
  }
}