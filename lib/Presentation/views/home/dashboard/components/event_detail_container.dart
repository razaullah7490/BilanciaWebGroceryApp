// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Domain/models/manager/event_model.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/routes/navigation.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/views/home/dashboard/agenda/events/Bloc/event_cubit.dart';
import 'package:grocery/Presentation/views/home/dashboard/agenda/events/all_events.dart';
import 'package:grocery/Presentation/views/home/dashboard/agenda/events/edit_event.dart';
import '../../../../common/delete_item_dialogue.dart';
import '../../../../common/edit_delete_container.dart';
import '../../../../common/snack_bar_widget.dart';
import '../../../../resources/border_radius.dart';
import '../../../../resources/colors_palette.dart';
import '../../../../resources/size.dart';
import '../../../../resources/text_styles.dart';
import 'package:intl/intl.dart';

class EventDetailContainer extends StatefulWidget {
  final EventModel model;
  const EventDetailContainer({
    super.key,
    required this.model,
  });

  @override
  State<EventDetailContainer> createState() => _EventDetailContainerState();
}

class _EventDetailContainerState extends State<EventDetailContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSize.m10,
        vertical: AppSize.m6,
      ).r,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.p18,
        vertical: AppSize.p18,
      ).r,
      decoration: BoxDecoration(
          color: AppColors.searchTextFieldColor,
          borderRadius:
              BorderRadius.circular(AppBorderRadius.dashboardSliderBorderRadius)
                  .r,
          border: Border.all(
            color: AppColors.primaryColor,
            width: 0.5.w,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleText(widget.model.title),
                CustomSizedBox.height(5),
                subTitleText(
                    "${AppStrings.participantsText}: ${widget.model.participants.length}"),
                subTitleText(
                    "${AppStrings.beginDateText}: ${getHumanReadableDateAndTime(widget.model.beginDate)}"),
                subTitleText(
                    "${AppStrings.endDateText}: ${getHumanReadableDateAndTime(widget.model.endDate)}"),
              ],
            ),
          ),
          editDeleteIcons(
            onTapDelete: () => deleteEventDialogue(context),
            onTapEdit: () {
              final args = EventModel(
                beginDate: widget.model.beginDate,
                endDate: widget.model.endDate,
                title: widget.model.title,
                description: widget.model.description,
                participants: widget.model.participants,
                eventTag: widget.model.eventTag,
                id: widget.model.id,
              );
              Navigate.to(context, EditEventScreen(model: args));
            },
          ),
        ],
      ),
    );
  }

  Text subTitleText(String text) {
    return Text(
      text,
      style: Styles.segoeUI(
        AppSize.text13.sp,
        AppColors.containerTextColor,
      ),
    );
  }

  Widget titleText(String text) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: Styles.circularStdMedium(
        AppSize.text16.sp,
        AppColors.containerTextColor,
      ),
    );
  }

  String getHumanReadableDateAndTime(dt) {
    DateTime dateTime = DateTime.parse(dt);
    return DateFormat('MMM dd, yyyy').add_jm().format(dateTime);
  }

  Future<void> deleteEventDialogue(BuildContext context) async {
    return showDialog<void>(
        barrierColor: AppColors.deleteDialogueBarrierColor,
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<EventCubit, EventState>(
            builder: (context, state) {
              return DeleteItemDialogue(
                text: AppStrings.resourceActionText,
                onDeleteButtonTap: () async {
                  await context.read<EventCubit>().deleteEvent(widget.model.id);
                  Navigator.of(context).pop();
                  Navigate.toReplace(context, const AllEventsScreen());
                  SnackBarWidget.buildSnackBar(
                    context,
                    AppStrings.eventDeleteSuccessText,
                    AppColors.greenColor,
                    Icons.check,
                    true,
                  );
                },
              );
            },
          );
        });
  }
}
