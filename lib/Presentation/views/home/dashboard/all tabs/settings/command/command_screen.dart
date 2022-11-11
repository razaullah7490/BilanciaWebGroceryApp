import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Presentation/common/shimmer%20effect/tag_shimmer.dart';
import 'package:grocery/Presentation/views/home/dashboard/all%20tabs/settings/command/bloc/command_cubit.dart';
import '../../../../../../common/add_item_button.dart';
import '../../../../../../common/app_bar.dart';
import '../../../../../../common/data_not_available_text.dart';
import '../../../../../../resources/app_strings.dart';
import '../../../../../../resources/colors_palette.dart';
import '../../../../../../resources/sized_box.dart';
import '../../components/command_detail_container.dart';
import 'add_command_dailogue.dart';

class CommandScreen extends StatefulWidget {
  const CommandScreen({Key? key}) : super(key: key);

  @override
  State<CommandScreen> createState() => _CommandScreenState();
}

class _CommandScreenState extends State<CommandScreen> {
  @override
  void initState() {
    Future.wait([
      context.read<CommandCubit>().getCommands(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.commandText,
      ),
      body: Column(
        children: [
          CustomSizedBox.height(20),
          addItemButtonWidget(
            context: context,
            text: AppStrings.addCommandText,
            onTap: () => addCommandDialogue(context),
          ),
          CustomSizedBox.height(15),
          BlocBuilder<CommandCubit, CommandState>(
            builder: (context, state) {
              if (state.status == CommandEnum.loading) {
                return const TagListTileShimmerEffect();
              }
              return state.model.isEmpty
                  ? DataNotAvailableText.withExpanded(
                      AppStrings.noCommandAddedText,
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: state.model.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var model = state.model[index];
                          return CommandDetailContainer(model: model);
                        },
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }

  Future<void> addCommandDialogue(BuildContext context) async {
    return showDialog<void>(
        barrierColor: AppColors.deleteDialogueBarrierColor,
        context: context,
        builder: (BuildContext context) {
          return const CommandAddDialogue();
        });
  }
}
