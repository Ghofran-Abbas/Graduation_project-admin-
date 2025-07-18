// lib/features/employee/presentation/views/widgets/employees_view_body.dart

import 'package:admin_alhadara_dashboard/features/employee/presentation/views/widgets/register_secretary_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/go_router_path.dart';
import '../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../core/widgets/secretary/list_view_information_field.dart';

import '../../../data/models/employees_model.dart';
import '../../manager/create_employee_cubit/create_employee_cubit.dart';
import '../../manager/create_employee_cubit/create_employee_state.dart';
import '../../manager/delete_employee_cubit/delete_employee_cubit.dart';
import '../../manager/delete_employee_cubit/delete_employee_state.dart';
import '../../manager/employees_cubit/employees_cubit.dart';
import '../../manager/employees_cubit/employees_state.dart';
import '../../manager/register_secretary_cubit/register_secretary_cubit.dart';
import '../../manager/register_secretary_cubit/register_secretary_state.dart';
import '../../manager/update_employee_cubit/update_employee_cubit.dart';
import '../../manager/update_employee_cubit/update_employee_state.dart';

import 'create_employee_dialog.dart';
import 'update_employee_dialog.dart';

class EmployeesViewBody extends StatefulWidget {
  const EmployeesViewBody({Key? key}) : super(key: key);

  @override
  State<EmployeesViewBody> createState() => _EmployeesViewBodyState();
}

class _EmployeesViewBodyState extends State<EmployeesViewBody> {
  final _searchController = TextEditingController();
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final cubit = context.read<EmployeesCubit>();
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll >= maxScroll - 200) {
      cubit.fetchNextPage();
    }
  }

  Future<void> _showAddDialog() async {
    final added = await showDialog<bool>(
      context: context,
      builder:
          (_) => BlocProvider.value(
        value: context.read<CreateEmployeeCubit>(),
        child: const CreateEmployeeDialog(),
      ),
    );
    if (added == true) context.read<EmployeesCubit>().fetchFirstPage();
  }

  Future<void> _showRegisterSecretaryDialog() async {
    await showDialog<bool>(
      context: context,
      builder:
          (_) => BlocProvider.value(
        value: context.read<RegisterSecretaryCubit>(),
        child: const RegisterSecretaryDialog(),
      ),
    );
  }

  Future<void> _showEditDialog(Employee e) async {
    final updated = await showDialog<bool>(
      context: context,
      builder:
          (_) => BlocProvider.value(
        value: context.read<UpdateEmployeeCubit>(),
        child: UpdateEmployeeDialog(employee: e),
      ),
    );
    if (updated == true) context.read<EmployeesCubit>().fetchFirstPage();
  }

  Future<void> _confirmDelete(int id) async {
    final loc = AppLocalizations.of(context)!;
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder:
          (d) => AlertDialog(
        title: Text(loc.translate('Warning')),
        content: Text(
          loc.translate('Are you sure you want to delete this employee?'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(d, false),
            child: Text(loc.translate('Cancel')),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(d, true),
            child: Text(loc.translate('Confirm')),
          ),
        ],
      ),
    );
    if (shouldDelete == true)
      context.read<DeleteEmployeeCubit>().deleteEmployee(id);
  }

  Widget _buildHeader() {
    final loc = AppLocalizations.of(context)!;
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              loc.translate('Name'),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              loc.translate('Role'),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              loc.translate('Email'),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              loc.translate('Gender'),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 68.w), // space for icons column
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return BlocListener<RegisterSecretaryCubit, RegisterSecretaryState>(
      listener: (_, state) {
        if (state is RegisterSecretarySuccess){     CustomSnackBar.showSnackBar(
          context,
          msg: loc.translate('Secretary registered successfully'),
        );
        context.read<EmployeesCubit>().fetchFirstPage();
        }


        else if (state is RegisterSecretaryFailure)
          CustomSnackBar.showErrorSnackBar(context, msg: state.error);
      },
      child: BlocConsumer<CreateEmployeeCubit, CreateEmployeeState>(
        listener: (_, state) {
          if (state is CreateEmployeeFailure)
            CustomSnackBar.showErrorSnackBar(context, msg: state.error);
          else if (state is CreateEmployeeSuccess)
            CustomSnackBar.showSnackBar(
              context,
              msg: loc.translate('Employee created successfully'),
            );
        },
        builder:
            (_, __) => BlocConsumer<UpdateEmployeeCubit, UpdateEmployeeState>(
          listener: (_, state) {
            if (state is UpdateEmployeeFailure)
              CustomSnackBar.showErrorSnackBar(context, msg: state.error);
            else if (state is UpdateEmployeeSuccess)
              CustomSnackBar.showSnackBar(
                context,
                msg: loc.translate('Employee updated successfully'),
              );
          },
          builder:
              (
              _,
              __,
              ) => BlocConsumer<DeleteEmployeeCubit, DeleteEmployeeState>(
            listener: (_, state) {
              if (state is DeleteEmployeeFailure)
                CustomSnackBar.showErrorSnackBar(
                  context,
                  msg: state.error,
                );
              else if (state is DeleteEmployeeSuccess) {
                context.read<EmployeesCubit>().fetchFirstPage();
                CustomSnackBar.showSnackBar(
                  context,
                  msg: loc.translate('Employee deleted successfully'),
                );
              }
            },
            builder:
                (_, __) => BlocBuilder<EmployeesCubit, EmployeesState>(
              builder: (ctx, state) {
                if (state is EmployeesLoading)
                  return const Center(
                    child: CustomCircularProgressIndicator(),
                  );
                if (state is EmployeesFailure)
                  return CustomErrorWidget(
                    errorMessage: state.error,
                  );

                final success = state as EmployeesSuccess;
                final list = success.employees;
                final totalCount =
                    list.length + (success.hasMore ? 2 : 1);

                return Padding(
                  padding: EdgeInsets.only(top: 56.h),
                  child: CustomScreenBody(
                    title: loc.translate('Employees'),
                    showSearchField: true,
                    searchController: _searchController,
                    onTapSearch: () {
                      context.go('/employees/searchEmployee');
                    },
                    onPressedFirst: _showRegisterSecretaryDialog,
                    textFirstButton: loc.translate(
                      'Register Secretary',
                    ),
                    showFirstButton: true,
                    onPressedSecond: _showAddDialog,
                    textSecondButton: loc.translate('New employee'),
                    showSecondButton: true,
                    onPressedThird: () {
                      context.go('/employees/top-secretary');
                    },
                    textThirdButton: loc.translate(
                      'Most Points Secretary',
                    ),
                    showThirdButton: true,
                    body: Padding(
                      padding: EdgeInsets.only(
                        top: 238.h,
                        left: 20.w,
                        right: 20.w,
                        bottom: 27.h,
                      ),
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: totalCount,
                        itemBuilder: (context, index) {
                          if (index == 0) return _buildHeader();
                          final itemIndex = index - 1;
                          if (itemIndex < list.length) {
                            final e = list[itemIndex];
                            return Container(
                              height: 120.h,
                              padding: EdgeInsets.symmetric(
                                vertical: 12.h,
                                horizontal: 12.w,
                              ),
                              child: InformationFieldItem(
                                color:
                                itemIndex.isEven
                                    ? AppColors.white
                                    : AppColors
                                    .darkHighlightPurple,
                                image: e.photo,
                                imageWidth: 50.w,
                                imageHeight: 70.h,
                                imageBorderRadius: 90.h,
                                height: 100.h,
                                name: e.name,
                                secondText: e.role,
                                showSecondDetailsText: true,
                                thirdDetailsText: e.email,
                                fourthDetailsText: e.gender,
                                fifthText: e.points.toString(),
                                showIcons: true,
                                onTap:
                                    () => ctx.go(
                                  '${GoRouterPath.employees}/${e.id}',
                                ),
                                onTapFirstIcon:
                                    () => _showEditDialog(e),
                                onTapSecondIcon:
                                    () => _confirmDelete(e.id),
                              ),
                            );
                          }
                          // loader
                          return const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
