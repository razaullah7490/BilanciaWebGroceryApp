import 'package:grocery/Application/exports.dart';

class ManageProductsUpperTiles extends StatefulWidget {
  final VoidCallback productsTap;
  final VoidCallback categoriesTap;
  final bool isProductSelected;
  const ManageProductsUpperTiles({
    Key? key,
    required this.productsTap,
    required this.categoriesTap,
    required this.isProductSelected,
  }) : super(key: key);

  @override
  State<ManageProductsUpperTiles> createState() =>
      _ManageProductsUpperTilesState();
}

class _ManageProductsUpperTilesState extends State<ManageProductsUpperTiles>
    with TickerProviderStateMixin {
  AnimationController? _animationController1;
  AnimationController? _animationController2;

  @override
  void initState() {
    super.initState();
    _animationController1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
      lowerBound: 0.0,
      upperBound: 0.2,
    )..addListener(() {
        setState(() {});
      });

    _animationController2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
      lowerBound: 0.0,
      upperBound: 0.2,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController1!.dispose();
    _animationController2!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double scale1 = 1 + _animationController1!.value;
    double scale2 = 1 + _animationController2!.value;

    return Row(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: onTapDown1,
          onTapUp: onTapUp1,
          onTapCancel: onTapCancel1,
          onTap: widget.productsTap,
          child: topTwoTiles(
            AppStrings.productsText,
            AppColors.manageProductTile1Color,
            scale1,
            widget.isProductSelected
                ? const Color.fromARGB(255, 196, 222, 255)
                : Colors.transparent,
          ),
        ),
        CustomSizedBox.width(10),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: onTapDown2,
          onTapUp: onTapUp2,
          onTapCancel: onTapCancel2,
          onTap: widget.categoriesTap,
          child: topTwoTiles(
            AppStrings.categoriesText,
            AppColors.manageProductTile2Color,
            scale2,
            widget.isProductSelected
                ? Colors.transparent
                : AppColors.dashContainerBorder2,
          ),
        ),
      ],
    );
  }

  Widget topTwoTiles(
    String text,
    Color color,
    double scale,
    Color borderColor,
  ) {
    return Transform.scale(
      scale: scale,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.p35,
          vertical: AppSize.p15,
        ).r,
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: 1.w,
          ),
          color: color,
          borderRadius:
              BorderRadius.circular(AppBorderRadius.manageProductTileRadius.r),
        ),
        child: Center(
          child: Text(
            text,
            style: Styles.circularStdBook(
              AppSize.text15.sp,
              AppColors.blackColor,
            ),
          ),
        ),
      ),
    );
  }

  onTapDown1(TapDownDetails details) {
    _animationController1!.forward();
  }

  onTapUp1(TapUpDetails details) {
    _animationController1!.reverse();
  }

  onTapCancel1() {
    _animationController1!.reverse();
  }

  onTapDown2(TapDownDetails details) {
    _animationController2!.forward();
  }

  onTapUp2(TapUpDetails details) {
    _animationController2!.reverse();
  }

  onTapCancel2() {
    _animationController2!.reverse();
  }
}
