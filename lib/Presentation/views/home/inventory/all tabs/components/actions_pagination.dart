import 'package:grocery/Application/exports.dart';

class ActionsPaginationWidget extends StatelessWidget {
  final int totalPages;
  final int initialPage;
  final ValueChanged onPageChanged;
  const ActionsPaginationWidget({
    Key? key,
    required this.initialPage,
    required this.totalPages,
    required this.onPageChanged,
  }) : super(key: key);

  final double containerSize = 30.0;
  final double iconSize = 24.0;
  final Color containerColor = AppColors.primaryColor;
  final Color iconColor = AppColors.whiteColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ).r,
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(
            AppBorderRadius.productionParkTileRadius.r,
          ),
          boxShadow: const [
            BoxShadow(
              spreadRadius: 2,
              blurRadius: 15,
              color: Colors.black26,
              offset: Offset(0, 3),
            ),
          ]),
      child: NumberPagination(
        controlButton: const SizedBox(),
        fontSize: 8.0,
        threshold: 4,
        iconToFirst: nextToAll(Icons.skip_previous_rounded),
        iconToLast: nextToAll(Icons.skip_next_rounded),
        iconNext: nextAndPrevious(Icons.navigate_next_rounded),
        iconPrevious: nextAndPrevious(Icons.navigate_before_rounded),
        onPageChanged: onPageChanged,
        pageTotal: totalPages,
        pageInit: initialPage,
        colorPrimary: AppColors.primaryColor,
        colorSub: Colors.white,
      ),
    );
  }

  Container nextAndPrevious(IconData icon) {
    return Container(
      width: containerSize.w,
      height: containerSize.w,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(
          AppBorderRadius.textFieldBorderRadius.r,
        ),
      ),
      child: Center(
        child: Icon(
          icon,
          size: iconSize.r,
          color: iconColor,
        ),
      ),
    );
  }

  Container nextToAll(IconData icon) {
    return Container(
      width: containerSize.w,
      height: containerSize.w,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(
          AppBorderRadius.textFieldBorderRadius.r,
        ),
      ),
      child: Center(
        child: Icon(
          icon,
          size: iconSize.r,
          color: iconColor,
        ),
      ),
    );
  }
}
