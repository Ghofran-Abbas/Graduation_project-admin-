import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_icon_button.dart';
import '../../../../../../core/widgets/custom_image_network.dart';
import '../../../../../../core/widgets/custom_number_pagination.dart';
import '../../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../../../core/widgets/secretary/custom_label_text_form_field.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/grid_view_cards.dart';
import '../../../../../../core/widgets/text_icon_button.dart';

class AnnouncementAViewBody extends StatefulWidget {
  const AnnouncementAViewBody({super.key});

  @override
  State<AnnouncementAViewBody> createState() => _AnnouncementAViewBodyState();
}

class _AnnouncementAViewBodyState extends State<AnnouncementAViewBody> {

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  Uint8List? selectedImage;


  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    nameController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
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

  /*void register() {
    if (_formKey.currentState!.validate() && selectedImage != null) {
      context.read<CreateCourseCubit>().fetchCreateCourse(
        departmentId: widget.depId,
        name: nameController.text,
        description: descriptionController.text,
        photo: selectedImage!,
      );
    } else {
      CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('Error, Please enter all the fields.'),);
    }
  }

  void update(int id) {
    context.read<UpdateCourseCubit>().fetchUpdateCourse(
      id: id,
      departmentId: widget.depId,
      name: nameController.text,
      description: descriptionController.text,
      photo: selectedImage,
    );
  }*/

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = ((screenWidth - 210) / 250).floor();
    crossAxisCount = crossAxisCount < 2 ? 2 : crossAxisCount;
    return Padding(
      padding: EdgeInsets.only(top: 56.0.h,),
      child: CustomScreenBody(
        title: 'English',
        showSearchField: true,
        onPressedFirst: () {},
        onPressedSecond: () {},
        onTapSearch: () {},
        body: Padding(
          padding: EdgeInsets.only(
              top: 238.0.h,
              left: 47.0.w,
              right: 47.0.w,
              bottom: 27.0.h),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*state.courses.courses.data!.isNotEmpty ? */GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount, crossAxisSpacing: 10.w, mainAxisExtent: 354.66.h),
                  itemBuilder: (BuildContext context, int index) {
                    return Align(child: CustomCard(
                      image: ''/*state.courses.courses.data![index].photo*/,
                      text: 'Discount 30%'/*state.courses.courses.data![index].name*/,
                      showIcons: true,
                      onTap: () {
                        context.go('${GoRouterPath.courses}/1${GoRouterPath.courseDetails}/1${GoRouterPath.announcementsA}/1${GoRouterPath.announcementADetails}/1');
                        //context.go('${GoRouterPath.courses}/${stateDC.course.course.departmentId}${GoRouterPath.courseDetails}/${stateDC.course.course.id}${GoRouterPath.announcements}/1');
                      },
                      onTapFirstIcon: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return StatefulBuilder(
                                builder: (BuildContext context,
                                    void Function(void Function()) setStateDialog) {
                                  return Form(
                                    key: _formKey,
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Container(
                                          width: 871.w,
                                          height: 788.h,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 160.w,
                                              vertical: 115.h),
                                          padding: EdgeInsets.all(22.r),
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius: BorderRadius.circular(
                                                6.r),
                                          ),
                                          child: SingleChildScrollView(
                                            physics: BouncingScrollPhysics(),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 65.h,
                                                      left: 60.w,
                                                      right: 155.w),
                                                  child: Text(
                                                    AppLocalizations.of(context).translate('Edit course'),
                                                    style: Styles.h3Bold(
                                                        color: AppColors.t3),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 60.w),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Stack(
                                                              children: [
                                                                selectedImage !=
                                                                    null
                                                                    ? CustomMemoryImage(
                                                                  image: selectedImage,
                                                                  imageWidth: 186
                                                                      .w,
                                                                  imageHeight: 186
                                                                      .w,
                                                                  borderRadius: 150
                                                                      .r,
                                                                )
                                                                    : CustomImageAsset(
                                                                  imageWidth: 186
                                                                      .w,
                                                                  imageHeight: 186
                                                                      .w,
                                                                  borderRadius: 150
                                                                      .r,
                                                                ),
                                                                Positioned(
                                                                  top: 140.w,
                                                                  left: 150.w,
                                                                  child: CustomIconButton(
                                                                    icon: Icons
                                                                        .add,
                                                                    onTap: () async {
                                                                      await pickImage();
                                                                      setStateDialog(() {});
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            CustomLabelTextFormField(
                                                              labelText: AppLocalizations.of(context).translate('Name'),
                                                              showLabelText: true,
                                                              controller: nameController,
                                                              topPadding: 68.h,
                                                              bottomPadding: 0
                                                                  .h,
                                                              leftPadding: 0.w,
                                                              rightPadding: 65
                                                                  .w,
                                                              validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('This field required') : null,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            CustomLabelTextFormField(
                                                              labelText: AppLocalizations.of(context).translate('Description'),
                                                              showLabelText: true,
                                                              controller: descriptionController,
                                                              boxHeight: 360.h,
                                                              maxLines: 11,
                                                              topPadding: 35.h,
                                                              bottomPadding: 0
                                                                  .h,
                                                              leftPadding: 0.w,
                                                              rightPadding: 128
                                                                  .w,
                                                              validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('This field required') : null,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 60.h,
                                                      bottom: 65.h,
                                                      left: 47.w,
                                                      right: 155.w),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    children: [
                                                      TextIconButton(
                                                        textButton: AppLocalizations.of(context).translate('Edit course'),
                                                        bigText: true,
                                                        textColor: AppColors.t3,
                                                        icon: Icons.add,
                                                        iconSize: 40.01.r,
                                                        iconColor: AppColors.t2,
                                                        iconLast: false,
                                                        firstSpaceBetween: 3.w,
                                                        buttonHeight: 53.h,
                                                        borderWidth: 0.w,
                                                        buttonColor: AppColors.white,
                                                        borderColor: Colors.transparent,
                                                        onPressed: () {
                                                          Navigator.pop(dialogContext);
                                                          //update(state.courses.courses.data![index].id);
                                                          nameController.clear();
                                                          descriptionController.clear();
                                                        },
                                                      ),
                                                      SizedBox(width: 42.w,),
                                                      TextIconButton(
                                                        textButton: AppLocalizations.of(context).translate('       Cancel       '),
                                                        textColor: AppColors.t3,
                                                        iconLast: false,
                                                        buttonHeight: 53.h,
                                                        borderWidth: 0.w,
                                                        borderRadius: 4.r,
                                                        buttonColor: AppColors
                                                            .w1,
                                                        borderColor: AppColors
                                                            .w1,
                                                        onPressed: () {
                                                          nameController
                                                              .clear();
                                                          descriptionController
                                                              .clear();
                                                          Navigator.pop(
                                                              dialogContext);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            );
                          },
                        );
                      },
                      onTapSecondIcon: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return Align(
                              alignment: Alignment.topRight,
                              child: Material(
                                color: Colors.transparent,
                                child: Container(
                                  width: 638.w,
                                  height: 478.h,
                                  margin: EdgeInsets.symmetric(horizontal: 280.w, vertical: 255.h),
                                  padding:  EdgeInsets.all(22.r),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 65.h, left: 30.w, right: 155.w),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.error_outline,
                                                color: AppColors.orange,
                                                size: 55.r,
                                              ),
                                              SizedBox(width: 10.w,),
                                              Text(
                                                AppLocalizations.of(context).translate('Warning'),
                                                style: Styles.h3Bold(color: AppColors.t3),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 75.h, left: 65.w, right: 155.w),
                                          child: Text(
                                            AppLocalizations.of(context).translate('Are you sure you want to delete this course?'),
                                            style: Styles.b2Normal(color: AppColors.t3),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 90.h, bottom: 65.h, left: 47.w, right: 155.w),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              TextIconButton(
                                                textButton: AppLocalizations.of(context).translate('Confirm'),
                                                bigText: true,
                                                textColor: AppColors.t3,
                                                icon: Icons.check_circle_outline,
                                                iconSize: 40.01.r,
                                                iconColor: AppColors.t2,
                                                iconLast: false,
                                                firstSpaceBetween: 3.w,
                                                buttonHeight: 53.h,
                                                borderWidth: 0.w,
                                                buttonColor: AppColors.white,
                                                borderColor: Colors.transparent,
                                                onPressed: (){
                                                  //context.read<DeleteCourseCubit>().fetchDeleteCourse(id: state.courses.courses.data![index].id);
                                                  Navigator.pop(dialogContext);
                                                },
                                              ),
                                              SizedBox(width: 42.w,),
                                              TextIconButton(
                                                textButton: AppLocalizations.of(context).translate('       Cancel       '),
                                                textColor: AppColors.t3,
                                                iconLast: false,
                                                buttonHeight: 53.h,
                                                borderWidth: 0.w,
                                                borderRadius: 4.r,
                                                buttonColor: AppColors.w1,
                                                borderColor: AppColors.w1,
                                                onPressed: (){
                                                  Navigator.pop(dialogContext);
                                                },
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ));
                  },
                  itemCount: 7/*state.courses.courses.data!.length*/,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                )/* : Center(heightFactor: 20.h,child: CustomErrorWidget(errorMessage: AppLocalizations.of(context).translate('No thing to display')))*/,
                CustomNumberPagination(
                  numberPages: 1/*state.courses.courses.lastPage*/,
                  initialPage: 1/*state.courses.courses.currentPage*/,
                  onPageChange: (int index) {
                    //context.read<CoursesCubit>().fetchCourses(page: index + 1);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
