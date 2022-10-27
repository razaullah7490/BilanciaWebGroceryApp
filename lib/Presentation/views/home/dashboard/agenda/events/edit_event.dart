// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Data/services/agenda/event_service.dart';
import 'package:grocery/Domain/models/manager/event_model.dart';
import 'package:grocery/Presentation/common/custom_button.dart';
import 'package:grocery/Presentation/views/home/dashboard/agenda/events/Bloc/event_cubit.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../../../../../../Data/errors/custom_error.dart';
import '../../../../../common/loading_indicator.dart';
import '../../../../../common/snack_bar_widget.dart';
import '../../../../../common/app_bar.dart';
import '../../../../../common/custom_text_field.dart';
import '../../../../../common/mult_line_text_field.dart';
import '../../../../../resources/app_strings.dart';
import '../../../../../resources/colors_palette.dart';
import '../../../../../resources/routes/navigation.dart';
import '../../../../../resources/size.dart';
import '../../../../../resources/sized_box.dart';
import '../../../../../resources/text_styles.dart';
import '../../components/event_date_time_widget.dart';
import '../../components/multi_select_drop_down.dart';
import '../../components/tag_drop_down.dart';
import '../tags/Bloc/tags_cubit.dart';
import 'Bloc/participants_cubit.dart';
import 'all_events.dart';

class EditEventScreen extends StatefulWidget {
  final EventModel model;
  const EditEventScreen({
    super.key,
    required this.model,
  });

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionContoller = TextEditingController();
  List<int> participantsList = [];
  DateTime? beginDateTime;
  DateTime? endDateTime;
  var tag;
  bool isParticipantsLoaded = true;

  @override
  void initState() {
    beginDateTime = DateTime.parse(widget.model.beginDate);
    endDateTime = DateTime.parse(widget.model.endDate);
    titleController.text = widget.model.title;
    descriptionContoller.text = widget.model.description;
    participantsList.addAll(widget.model.participants);
    tag = widget.model.eventTag == 0 ? tag : widget.model.eventTag;
    Future.wait([
      context.read<ParticipantsCubit>().getAllUsers(),
      context.read<TagsCubit>().getAllTags(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("Id ${widget.model.id}");
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.editEventText,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.p22).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSizedBox.height(15),
              textFieldUpperText(AppStrings.beginDateText),
              EventDateTimePicker.datePickerWidget(
                textWidget: Text(
                  beginDateTime == null
                      ? AppStrings.beginDateText
                      : "${beginDateTime!.year}/${beginDateTime!.month}/${beginDateTime!.day} ${beginDateTime!.hour.toString().padLeft(2, '0')}:${beginDateTime!.minute.toString().padLeft(2, '0')}",
                  style: Styles.circularStdBook(
                    AppSize.text15.sp,
                    beginDateTime == null
                        ? AppColors.hintTextColor
                        : AppColors.containerTextColor,
                  ),
                ),
                onTap: beginPickDateTime,
              ),
              CustomSizedBox.height(15),
              textFieldUpperText(AppStrings.endDateText),
              EventDateTimePicker.datePickerWidget(
                textWidget: Text(
                  endDateTime == null
                      ? AppStrings.endDateText
                      : "${endDateTime!.year}/${endDateTime!.month}/${endDateTime!.day} ${endDateTime!.hour.toString().padLeft(2, '0')}:${endDateTime!.minute.toString().padLeft(2, '0')}",
                  style: Styles.circularStdBook(
                    AppSize.text15.sp,
                    endDateTime == null
                        ? AppColors.hintTextColor
                        : AppColors.containerTextColor,
                  ),
                ),
                onTap: endPickDateTime,
              ),
              CustomSizedBox.height(15),
              textFields(),
              CustomSizedBox.height(40),
              BlocListener<EventCubit, EventState>(
                listener: (context, state) {
                  if (state.status == EventEnum.success) {
                    SnackBarWidget.buildSnackBar(
                      context,
                      AppStrings.eventUpdatedSuccessText,
                      AppColors.greenColor,
                      Icons.check,
                      true,
                    );
                    Navigator.of(context).pop();
                    Navigate.toReplace(context, const AllEventsScreen());
                  }
                  if (state.error != const CustomError(error: '')) {
                    SnackBarWidget.buildSnackBar(
                      context,
                      state.error.error,
                      AppColors.redColor,
                      Icons.close,
                      true,
                    );
                  }
                },
                child: BlocBuilder<EventCubit, EventState>(
                  builder: (context, state) {
                    if (state.status == EventEnum.loading) {
                      return LoadingIndicator.loading();
                    }
                    return Center(
                      child: CustomButton(
                        text: AppStrings.updateText,
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            Map<String, dynamic> map = {
                              "begin_datetime": beginDateTime.toString(),
                              "end_datetime": endDateTime.toString(),
                              "title": titleController.text,
                              "description": descriptionContoller.text,
                              "participants": participantsList,
                              "tag": tag == null ? "" : tag.toString(),
                            };
                            await context
                                .read<EventCubit>()
                                .editEvent(widget.model.id, map);
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
              CustomSizedBox.height(10),
            ],
          ),
        ),
      ),
    );
  }

  Widget textFields() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textFieldUpperText(AppStrings.titleText),
          CustomTextField(
            controller: titleController,
            labelText: AppStrings.titleText,
            hintText: AppStrings.enterTitleText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.text,
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideTitleText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(15),
          textFieldUpperText(AppStrings.descriptionText),
          MultiLineTextField(controller: descriptionContoller),
          CustomSizedBox.height(8),
          textFieldUpperText(AppStrings.participantsText),
          BlocListener<ParticipantsCubit, ParticipantsState>(
            listener: (context, state) {
              if (state.status == ParticipantsEnum.loading) {
                setState(() {
                  isParticipantsLoaded = true;
                });
              }

              if (state.status == ParticipantsEnum.success) {
                setState(() {
                  isParticipantsLoaded = false;
                });
              }
            },
            child: BlocBuilder<ParticipantsCubit, ParticipantsState>(
                builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  if (isParticipantsLoaded = true) {
                    SnackBarWidget.buildSnackBar(
                      context,
                      AppStrings.participantsLoadingText,
                      AppColors.greenColor,
                      Icons.check,
                      true,
                    );
                  }
                },
                behavior: HitTestBehavior.opaque,
                child: AbsorbPointer(
                  absorbing: isParticipantsLoaded,
                  child: MultiSelectDropDown(
                    initial: participantsList,
                    itemsMap: state.modelList
                        .map((e) => MultiSelectItem(
                            e.id, "${e.firstName} ${e.lastName}"))
                        .toList(),
                    onConfirm: (v) {
                      setState(() {
                        participantsList = v;
                      });
                      log("List ");
                    },
                    buttonText: Text(
                      "${participantsList.length} ${AppStrings.selectParticipantsText}",
                      style: Styles.circularStdBook(
                        AppSize.text14.sp,
                        AppColors.hintTextColor,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          CustomSizedBox.height(15),
          textFieldUpperText(AppStrings.tagText),
          BlocBuilder<TagsCubit, TagsState>(
            builder: (context, state) {
              return TagDropDown(
                hintText: AppStrings.selectTagText,
                value: tag,
                itemsMap: state.tagModel.map((v) {
                  return DropdownMenuItem(
                    value: v.id,
                    child: Text(v.name),
                  );
                }).toList(),
                onChanged: (v) {
                  setState(() {
                    tag = v;
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget textFieldUpperText(String text) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSize.p2,
      ).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style:
                Styles.circularStdBook(AppSize.text15.sp, AppColors.blackColor),
          ),
          CustomSizedBox.height(8),
        ],
      ),
    );
  }

  Future beginPickDateTime() async {
    DateTime? date = await EventDateTimePicker.pickDate(context);
    if (date == null) return;
    TimeOfDay? time = await EventDateTimePicker.pickTime(context);
    if (time == null) return;

    final newDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() => beginDateTime = newDateTime);
  }

  Future endPickDateTime() async {
    DateTime? date = await EventDateTimePicker.pickDate(context);
    if (date == null) return;
    TimeOfDay? time = await EventDateTimePicker.pickTime(context);
    if (time == null) return;
    final newDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    setState(() => endDateTime = newDateTime);
  }
}
