import 'package:grocery/Application/exports.dart';

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
                return const IvaAndIngredientShimmerEffect();
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
