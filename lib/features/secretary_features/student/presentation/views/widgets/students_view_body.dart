import 'dart:developer';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:number_paginator/number_paginator.dart';

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
import '../../../../../../core/widgets/secretary/custom_label_text_form_field.dart';
import '../../../../../../core/widgets/secretary/custom_list_information_fields.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/list_view_information_field.dart';
import '../../../../../../core/widgets/text_icon_button.dart';
import '../../manager/create_student_cubit/create_student_cubit.dart';
import '../../manager/create_student_cubit/create_student_state.dart';
import '../../manager/delete_student_cubit/delete_student_cubit.dart';
import '../../manager/delete_student_cubit/delete_student_state.dart';
import '../../manager/students_cubit/students_cubit.dart';
import '../../manager/students_cubit/students_state.dart';
import '../../manager/update_student_cubit/update_student_cubit.dart';
import '../../manager/update_student_cubit/update_student_state.dart';

class StudentsViewBody extends StatefulWidget {
  const StudentsViewBody({super.key});

  @override
  State<StudentsViewBody> createState() => _StudentsViewBodyState();
}

class _StudentsViewBodyState extends State<StudentsViewBody> {

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController birthDateController;
  late final TextEditingController genderController;
  late final TextEditingController passwordController;
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
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    birthDateController.dispose();
    genderController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          withData: true
      );
      if (result != null && result.files.single.bytes != null) {
        setState(() {
          selectedImage = result.files.single.bytes!;
        });
      } else {
        CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('No image selected or image data is unavailable.'),);
      }
    } catch (e) {
      CustomSnackBar.showErrorSnackBar(context, msg: '${AppLocalizations.of(context).translate('Failed to pick image:')} $e',);
    }
  }

  void register() {
    if (_formKey.currentState!.validate() && selectedImage != null) {
      context.read<CreateStudentCubit>().fetchCreateStudent(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
        birthday: birthDateController.text,
        photo: selectedImage!,
      );
    } else {
      CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('Error, Please enter all the fields.'),);
    }
  }

  void update(int id) {
    context.read<UpdateStudentCubit>().fetchUpdateStudent(
      id: id,
      name: nameController.text,
      phone: phoneController.text,
      birthday: birthDateController.text,
      gender: genderController.text,
      photo: selectedImage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentsCubit, StudentsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if(state is StudentsSuccess) {
            return Padding(
              padding: EdgeInsets.only(top: 56.0.h,),
              child: CustomScreenBody(
                title: AppLocalizations.of(context).translate('Students'),
                showSearchField: true,
                textFirstButton: AppLocalizations.of(context).translate('Most points'),
                showFirstButton: true,
                onPressedFirst: () {},
                onPressedSecond: () {},
                onTapSearch: () {
                  context.go(GoRouterPath.searchStudent);
                },
                body: state.showResult.students.data != null ? Padding(
                  padding: EdgeInsets.only(top: 238.0.h,
                      left: 20.0.w,
                      right: 20.0.w,
                      bottom: 27.0.h),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        CustomListInformationFields(
                          secondField: AppLocalizations.of(context).translate('Birth date'),
                          showSecondField: true,
                          widget: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return Align(child: InformationFieldItem(
                                color: index % 2 != 0 ? AppColors.darkHighlightPurple : AppColors.white,
                                image: state.showResult.students.data![index].photo,
                                name: state.showResult.students.data![index].name,
                                secondText: state.showResult.students.data![index].birthday,
                                showSecondDetailsText: true,
                                thirdDetailsText: state.showResult.students.data![index].email,
                                fourthDetailsText: 'Female',

                                onTap: () {
                                  context.go('${GoRouterPath.studentDetails}/${state.showResult.students.data![index].id}');
                                },
                                onTapFirstIcon: () {},
                                onTapSecondIcon: () {},
                              ));
                            },
                            itemCount: state.showResult.students.data!.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                          ),
                        ),
                        CustomNumberPagination(
                          numberPages: state.showResult.students.lastPage,
                          initialPage: state.showResult.students.currentPage,
                          onPageChange: (int index) {
                            context.read<StudentsCubit>().fetchStudents(page: index + 1);
                          },
                        ),
                      ],
                    ),
                  ),
                ) : Center(child: CustomErrorWidget(errorMessage: AppLocalizations.of(context).translate('No thing to display'))),
              ),
            );
          } else if(state is StudentsFailure) {
            return CustomErrorWidget(errorMessage: state.errorMessage);
          } else {
            return CustomCircularProgressIndicator();
          }
        }
    );
  }
}
