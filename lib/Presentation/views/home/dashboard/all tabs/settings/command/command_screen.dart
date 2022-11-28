import 'package:grocery/Application/exports.dart';

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
                return const CommandShimmerEffect();
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
