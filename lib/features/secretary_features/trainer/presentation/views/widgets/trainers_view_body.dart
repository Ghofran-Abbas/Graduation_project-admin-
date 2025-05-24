import 'dart:developer';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_icon_button.dart';
import '../../../../../../core/widgets/custom_image_network.dart';
import '../../../../../../core/widgets/custom_number_pagination.dart';
import '../../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../../../core/widgets/secretary/custom_dropdown_list.dart';
import '../../../../../../core/widgets/secretary/custom_empty_widget.dart';
import '../../../../../../core/widgets/secretary/custom_label_text_form_field.dart';
import '../../../../../../core/widgets/secretary/custom_list_information_fields.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/list_view_information_field.dart';
import '../../../../../../core/widgets/text_icon_button.dart';
import '../../manager/create_trainer_cubit/create_trainer_cubit.dart';
import '../../manager/create_trainer_cubit/create_trainer_state.dart';
import '../../manager/delete_trainer_cubit/delete_trainer_cubit.dart';
import '../../manager/delete_trainer_cubit/delete_trainer_state.dart';
import '../../manager/trainers_cubit/trainers_cubit.dart';
import '../../manager/trainers_cubit/trainers_state.dart';
import '../../manager/update_trainer_cubit/update_trainer_cubit.dart';
import '../../manager/update_trainer_cubit/update_trainer_state.dart';

class TrainersViewBody extends StatefulWidget {
  const TrainersViewBody({super.key});

  @override
  State<TrainersViewBody> createState() => _TrainersViewBodyState();
}

class _TrainersViewBodyState extends State<TrainersViewBody> {

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController birthDateController;
  late final TextEditingController genderController;
  late final TextEditingController passwordController;
  late final TextEditingController specificationController;
  late final TextEditingController experienceController;
  Uint8List? selectedImage;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    birthDateController = TextEditingController();
    genderController = TextEditingController();
    passwordController = TextEditingController();
    specificationController = TextEditingController();
    experienceController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    birthDateController.dispose();
    genderController.dispose();
    specificationController.dispose();
    experienceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrainersCubit, TrainersState>(
        listener: (context, state) {},
        builder: (context, state) {
          if(state is TrainersSuccess){
            return Padding(
              padding: EdgeInsets.only(top: 56.0.h,),
              child: CustomScreenBody(
                title: AppLocalizations.of(context).translate('Trainers'),
                showSearchField: true,
                onPressedFirst: () {},
                onPressedSecond: () {},
                onTapSearch: () {
                  context.go(GoRouterPath.searchTrainer);
                },
                body: Padding(
                  padding: EdgeInsets.only(top: 238.0.h,
                      left: 20.0.w,
                      right: 20.0.w,
                      bottom: 27.0.h),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        state.showResult.trainers.data!.isNotEmpty ? CustomListInformationFields(
                          secondField: AppLocalizations.of(context).translate('Subject'),
                          showSecondField: true,
                          widget: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return Align(child: InformationFieldItem(
                                color: index%2 != 0 ? AppColors.darkHighlightPurple : AppColors.white,
                                image: state.showResult.trainers.data![index].photo,
                                name: state.showResult.trainers.data![index].name,
                                secondText: state.showResult.trainers.data![index].specialization,
                                thirdDetailsText: state.showResult.trainers.data![index].email,
                                fourthDetailsText: state.showResult.trainers.data![index].gender,
                                showSecondDetailsText: true,
                                onTap: (){
                                  context.go('${GoRouterPath.trainerDetails}/${state.showResult.trainers.data![index].id}');
                                },
                                onTapFirstIcon: () {},
                                onTapSecondIcon: () {},
                              ));
                            },
                            itemCount: state.showResult.trainers.data!.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                          ),
                        ) : CustomEmptyWidget(
                          firstText: AppLocalizations.of(context).translate('No trainers at this time'),
                          secondText: AppLocalizations.of(context).translate('Trainers will appear here after they enroll in your institute.'),
                        ),
                        CustomNumberPagination(
                          numberPages: state.showResult.trainers.lastPage,
                          initialPage: state.showResult.trainers.currentPage,
                          onPageChange: (int index) {
                            context.read<TrainersCubit>().fetchTrainers(page: index + 1);
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ),
            );
          } else if(state is TrainersFailure) {
            return CustomErrorWidget(errorMessage: state.errorMessage);
          } else {
            return CustomCircularProgressIndicator();
          }
        }
    );
  }
}
