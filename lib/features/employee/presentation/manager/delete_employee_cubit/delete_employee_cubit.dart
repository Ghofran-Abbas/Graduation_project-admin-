// cubits/delete_employee_cubit.dart
import 'package:bloc/bloc.dart';
import '../../../data/repos/employee_repo.dart';
import 'delete_employee_state.dart';


class DeleteEmployeeCubit extends Cubit<DeleteEmployeeState> {
  final EmployeeRepo _repo;
  DeleteEmployeeCubit(this._repo) : super(DeleteEmployeeInitial());

  Future<void> deleteEmployee(int id) async {
    try {
      emit(DeleteEmployeeLoading());
      await _repo.delete(id);
      emit(DeleteEmployeeSuccess());
    } catch (e) {
      emit(DeleteEmployeeFailure(e.toString()));
    }
  }
}