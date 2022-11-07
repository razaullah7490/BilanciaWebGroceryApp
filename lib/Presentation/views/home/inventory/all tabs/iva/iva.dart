import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Presentation/common/extensions/media_query_extension.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/components/iva_detail_container.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/iva/add_iva.dart';
import '../../../../../common/add_item_button.dart';
import '../../../../../common/app_bar.dart';
import '../../../../../common/data_not_available_text.dart';
import '../../../../../common/loading_indicator.dart';
import '../../../../../resources/app_strings.dart';
import '../../../../../resources/sized_box.dart';
import 'ivaBloc/manager_iva_cubit.dart';

class IvaScreen extends StatefulWidget {
  const IvaScreen({super.key});

  @override
  State<IvaScreen> createState() => _IvaScreenState();
}

class _IvaScreenState extends State<IvaScreen> {
  @override
  void initState() {
    Future.wait([
      context.read<ManagerIvaCubit>().getIva(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.aliquotaIVAText,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSizedBox.height(20),
            addItemButtonWidget(
              context: context,
              text: AppStrings.addIvaText,
              onTap: () async {
                await showModalBottomSheet(
                  elevation: 10,
                  barrierColor: Colors.transparent,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => const AddIvaBottomSheet(),
                );
              },
            ),
            CustomSizedBox.height(15),
            BlocBuilder<ManagerIvaCubit, ManagerIvaState>(
                builder: (context, state) {
              if (state.status == IvaEnum.loading) {
                return SizedBox(
                    height: MediaQueryValues(context).height,
                    child: LoadingIndicator.loading());
              }
              return state.modelList.isEmpty
                  ? SizedBox(
                      height: MediaQueryValues(context).height,
                      child: DataNotAvailableText.withOutExpanded(
                        AppStrings.noIvaAddedText,
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.modelList.length,
                      itemBuilder: (context, index) {
                        var model = state.modelList[index];
                        return IVADetailContainer(model: model);
                      });
            }),
          ],
        ),
      ),
    );
  }
}
