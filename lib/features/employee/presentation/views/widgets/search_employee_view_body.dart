// lib/features/employee/presentation/pages/search_employee_view_body.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../core/widgets/custom_number_pagination.dart';
import '../../../../../core/widgets/secretary/custom_empty_widget.dart';
import '../../../../../core/widgets/secretary/custom_list_information_fields.dart';
import '../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../core/widgets/secretary/list_view_information_field.dart';
import '../../manager/search_employee_cubit/search_employee_cubit.dart';
import '../../manager/search_employee_cubit/search_employee_state.dart';



class SearchEmployeeViewBody extends StatelessWidget {
  SearchEmployeeViewBody({Key? key}) : super(key: key);
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchEmployeeCubit, SearchEmployeeState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: 56.0.h),
          child: CustomScreenBody(onPressedFirst: (){},onPressedSecond: (){},
            title: AppLocalizations.of(context).translate('Search'),
            turnSearch: true,
            searchController: searchController,
            onFieldSubmitted: (_) {
              context.read<SearchEmployeeCubit>()
                  .fetchSearchEmployee(querySearch: searchController.text, page: 1);
            },
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 170.0.h),
              child: state is SearchEmployeeLoading
                  ? CustomCircularProgressIndicator()
                  : state is SearchEmployeeFailure
                  ? CustomErrorWidget(errorMessage: state.errorMessage)
                  : state is SearchEmployeeSuccess
                  ? _buildResults(context, state)
                  : const Center(child: CustomEmptyWidget(firstText: 'Search to see results', secondText: '',)),
            ),
          ),
        );
      },
    );
  }

  Widget _buildResults(BuildContext context, SearchEmployeeSuccess state) {
    final list = state.employee.employees.data!;
    return Column(
      children: [
        list.isNotEmpty
            ? CustomListInformationFields(
          secondField: AppLocalizations.of(context).translate('Role'),
          showSecondField: true,
          widget: ListView.builder(
            itemCount: list.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, idx) {
              final e = list[idx];
              return Align(
                child: InformationFieldItem(onTapFirstIcon: (){},onTapSecondIcon: (){},
                  color: idx.isOdd ? AppColors.darkHighlightPurple : AppColors.white,
                  image: e.photo,
                  name: e.name,
                  secondText: e.role,
                  showSecondDetailsText: true,
                  thirdDetailsText: e.email,
                  fourthDetailsText: e.gender,
                  showIcons: true,
                  hideFirstIcon: true,
                  hideSecondIcon: true,
                  onTap: () {
                    context.go('/employees/${e.id}');
                  },
                ),
              );
            },
          ),
        )
            : CustomEmptyWidget(secondText: '',
          firstText: AppLocalizations.of(context).translate('Nothing to display'),
        ),
        CustomNumberPagination(
          numberPages: state.employee.employees.lastPage,
          initialPage: state.employee.employees.currentPage - 1,
          onPageChange: (idx) {
            context.read<SearchEmployeeCubit>()
                .fetchSearchEmployee(querySearch: searchController.text, page: idx + 1);
          },
        ),
      ],
    );
  }
}
