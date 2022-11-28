// ignore_for_file: use_build_context_synchronously
import 'package:grocery/Application/exports.dart';

class TagDetailContainer extends StatelessWidget {
  final TagModel model;
  const TagDetailContainer({
    super.key,
    required this.model,
  });

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
                Row(
                  children: [
                    titleText(AppStrings.nameText),
                    subTitleText(model.name),
                  ],
                ),
                CustomSizedBox.height(6),
                Row(
                  children: [
                    titleText(AppStrings.colorText),
                    subTitleText(model.color),
                  ],
                ),
              ],
            ),
          ),
          editDeleteIcons(
            onTapDelete: () => deleteTagDialogue(context),
            onTapEdit: () {
              Navigate.to(
                  context,
                  EditTagScreen(
                    name: model.name,
                    id: model.id,
                    color: model.color,
                  ));
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
        AppSize.text14.sp,
        AppColors.containerTextColor,
      ),
    );
  }

  Widget titleText(String text) {
    return Text(
      "$text: ",
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: Styles.circularStdMedium(
        AppSize.text16.sp,
        AppColors.containerTextColor,
      ),
    );
  }

  Future<void> deleteTagDialogue(BuildContext context) async {
    return showDialog<void>(
        barrierColor: AppColors.deleteDialogueBarrierColor,
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<TagsCubit, TagsState>(
            builder: (context, state) {
              return DeleteItemDialogue(
                text: model.name.toString(),
                onDeleteButtonTap: () async {
                  await context.read<TagsCubit>().deleteTag(model.id);
                  Navigator.of(context).pop();
                  Navigate.toReplace(context, const AllTagsScreen());
                  SnackBarWidget.buildSnackBar(
                    context,
                    AppStrings.tagDeleteSuccessText,
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
