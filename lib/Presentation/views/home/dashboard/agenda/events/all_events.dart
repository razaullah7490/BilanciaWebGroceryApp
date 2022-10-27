import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Data/services/agenda/event_service.dart';
import 'package:grocery/Presentation/views/home/dashboard/agenda/events/Bloc/event_cubit.dart';
import 'package:grocery/Presentation/views/home/dashboard/agenda/events/add_event.dart';
import 'package:grocery/Presentation/views/home/dashboard/components/event_detail_container.dart';

import '../../../../../common/add_item_button.dart';
import '../../../../../common/app_bar.dart';
import '../../../../../common/data_not_available_text.dart';
import '../../../../../common/loading_indicator.dart';
import '../../../../../resources/app_strings.dart';
import '../../../../../resources/routes/navigation.dart';
import '../../../../../resources/sized_box.dart';

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
              return LoadingIndicator.loadingExpanded();
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
