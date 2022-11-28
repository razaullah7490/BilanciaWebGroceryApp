import 'package:grocery/Application/exports.dart';

class AllEventsScreen extends StatefulWidget {
  const AllEventsScreen({super.key});

  @override
  State<AllEventsScreen> createState() => _AllEventsScreenState();
}

class _AllEventsScreenState extends State<AllEventsScreen> {
  @override
  void initState() {
    Future.wait([
      context.read<EventCubit>().getEvent(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.allEventsText,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSizedBox.height(15),
          addItemButtonWidget(
            context: context,
            text: AppStrings.addEventText,
            onTap: () => Navigate.to(context, const AddEventScreen()),
          ),
          CustomSizedBox.height(20),
          BlocBuilder<EventCubit, EventState>(builder: (context, state) {
            if (state.status == EventEnum.loading) {
              return const ListTileShimmerEffect();
            }
            return state.eventModel.isEmpty
                ? DataNotAvailableText.withExpanded(
                    AppStrings.noEventsAddedText,
                  )
                : Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.eventModel.length,
                      itemBuilder: (context, index) {
                        var model = state.eventModel[index];
                        return EventDetailContainer(model: model);
                      },
                    ),
                  );
          }),
        ],
      ),
    );
  }
}
