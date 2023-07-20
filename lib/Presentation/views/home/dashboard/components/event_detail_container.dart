// ignore_for_file: use_build_context_synchronously
import 'package:grocery/Application/exports.dart';
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
              return DeleteItemDialogue2(
                text: widget.model.title,
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
