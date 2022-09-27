import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Presentation/common/add_item_button.dart';
import 'package:grocery/Presentation/common/app_bar.dart';
import 'package:grocery/Presentation/common/data_not_available_text.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/routes/routes_names.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/components/resource_action_detail.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/resourceActions/bloc/resource_action_cubit.dart';

class ResourceActionsScreen extends StatefulWidget {
  const ResourceActionsScreen({super.key});

  @override
  State<ResourceActionsScreen> createState() => _ResourceActionsScreenState();
}

class _ResourceActionsScreenState extends State<ResourceActionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.resourceActionText,
      ),
      body: Column(
        children: [
          CustomSizedBox.height(20),
          addItemButtonWidget(
            context: context,
            text: AppStrings.addActionText,
            onTap: () => Navigator.pushNamed(
                context, RoutesNames.addResourceActionsScreen),
          ),
          CustomSizedBox.height(25),
          BlocBuilder<ResourceActionCubit, ResourceActionState>(
              builder: (context, state) {
            return state.resourceActionModel.isEmpty
                ? DataNotAvailableText.withExpanded(
                    AppStrings.noResourceActionAddedText,
                  )
                : Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.resourceActionModel.length,
                        itemBuilder: (context, index) {
                          var singleData = state.resourceActionModel[index];
                          return ResourceActionDetailContainer(
                              model: singleData);
                        }),
                  );
          }),
        ],
      ),
    );
  }
}
